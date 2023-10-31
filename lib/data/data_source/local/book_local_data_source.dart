import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

class BookLocalDataSourceImpl implements IBookLocalDataSource {
  const BookLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<void> upsertBooks(List<BookModel> books) async {
    return db.transaction(() async {
      await db.batch(
        (Batch batch) => batch.insertAllOnConflictUpdate(
          db.bookEntity,
          books.map((BookModel e) => e.entity),
        ),
      );

      final Set<String> authorSet = books
          .map((BookModel book) => book.authors)
          .expand((List<String> authors) => authors)
          .toSet();

      final AuthorMap authorMap = await db.authorDao.insertAllReturning(authorSet);

      await db.bookAuthorDao.insertBookAuthors(books: books, authorMap: authorMap);
    });
  }

  @override
  Future<Iterable<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    final String substring = queryParameters.query.toLowerCase();

    final List<Join<HasResultSet, dynamic>> joins = <Join<HasResultSet, dynamic>>[
      innerJoin(db.bookAuthorEntity, db.bookAuthorEntity.bookId.equalsExp(db.bookEntity.id)),
      innerJoin(db.authorEntity, db.authorEntity.id.equalsExp(db.bookAuthorEntity.authorId)),
    ];

    final Expression<bool> expression = db.bookEntity.title.lower().contains(substring) |
        db.bookEntity.description.lower().contains(substring);

    final JoinedSelectStatement<HasResultSet, dynamic> query = db.select(db.bookEntity).join(joins)
      ..where(expression)
      ..limit(queryParameters.maxResults, offset: queryParameters.startIndex);

    final List<TypedResult> result = await query.get();

    final Iterable<BookEntityData> bookEntity =
        result.map((TypedResult e) => e.readTable(db.bookEntity));

    final Iterable<AuthorEntityData> authorEntity =
        result.map((TypedResult e) => e.readTable(db.authorEntity));

    final Iterable<BookAuthorEntityData> bookAuthorEntity =
        result.map((TypedResult e) => e.readTable(db.bookAuthorEntity));

    return bookEntity.map((BookEntityData book) {
      final Iterable<int> authorIds = bookAuthorEntity
          .where((BookAuthorEntityData bookAuthor) => bookAuthor.bookId == book.id)
          .map((BookAuthorEntityData bookAuthor) => bookAuthor.authorId);

      final Iterable<AuthorEntityData> authors =
          authorEntity.where((AuthorEntityData author) => authorIds.contains(author.id));

      return (book: book, authors: authors).model;
    });
  }

  @override
  Future<void> addBookToFavourites({required int userId, required String bookId}) async {
    final UserBookEntityCompanion userBook = UserBookEntityCompanion(
      userId: Value<int>(userId),
      bookId: Value<String>(bookId),
    );
    await db.into(db.userBookEntity).insert(userBook, mode: InsertMode.insertOrIgnore);
  }

  @override
  Future<void> deleteBookFromFavourites({required int id}) async {
    await (db.delete(db.userBookEntity)
          ..where(
            ($UserBookEntityTable userBook) => userBook.id.equals(id),
          ))
        .go();
  }

  @override
  Stream<List<BookModel>> getUserBooksStream({required int userId}) {
    final Expression<bool> expression = db.userBookEntity.userId.equals(userId);

    final List<Join<HasResultSet, dynamic>> joins = <Join<HasResultSet, dynamic>>[
      innerJoin(
        db.userBookEntity,
        db.userBookEntity.userId.equals(userId) &
            db.userBookEntity.bookId.equalsExp(db.bookEntity.id),
      ),
      innerJoin(db.bookAuthorEntity, db.bookAuthorEntity.bookId.equalsExp(db.bookEntity.id)),
      innerJoin(db.authorEntity, db.authorEntity.id.equalsExp(db.bookAuthorEntity.authorId)),
    ];

    final JoinedSelectStatement<HasResultSet, dynamic> query = db.select(db.bookEntity).join(joins)
      ..where(expression);

    return query.watch().map((List<TypedResult> rows) {
      final Iterable<BookEntityData> bookEntity =
          rows.map((TypedResult e) => e.readTable(db.bookEntity));

      final Iterable<AuthorEntityData> authorEntity =
          rows.map((TypedResult e) => e.readTable(db.authorEntity));

      final Iterable<BookAuthorEntityData> bookAuthorEntity =
          rows.map((TypedResult e) => e.readTable(db.bookAuthorEntity));

      final Iterable<BookModel> books = bookEntity.map((BookEntityData book) {
        final Iterable<int> authorIds = bookAuthorEntity
            .where((BookAuthorEntityData bookAuthor) => bookAuthor.bookId == book.id)
            .map((BookAuthorEntityData bookAuthor) => bookAuthor.authorId);

        final Iterable<AuthorEntityData> authors =
            authorEntity.where((AuthorEntityData author) => authorIds.contains(author.id));

        return (book: book, authors: authors).model;
      });

      return books.toList(growable: false);
    });
  }
}
