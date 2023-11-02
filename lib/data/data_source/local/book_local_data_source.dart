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
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    final String substring = queryParameters.query.toLowerCase();
    final String langRestrict = queryParameters.languageCode.name;

    final List<Join<HasResultSet, dynamic>> joins = <Join<HasResultSet, dynamic>>[
      innerJoin(db.bookAuthorEntity, db.bookAuthorEntity.bookId.equalsExp(db.bookEntity.id)),
      innerJoin(db.authorEntity, db.authorEntity.id.equalsExp(db.bookAuthorEntity.authorId)),
    ];

    final Expression<bool> expression = db.bookEntity.language.equals(langRestrict) &
        (db.bookEntity.title.lower().contains(substring) |
            db.bookEntity.description.lower().contains(substring));

    final JoinedSelectStatement<HasResultSet, dynamic> query = db.select(db.bookEntity).join(joins)
      ..where(expression)
      ..limit(queryParameters.maxResults, offset: queryParameters.startIndex);

    final List<TypedResult> rows = await query.get();

    return rows.mapToBooks(database: db);
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
  Future<void> deleteBookFromFavourites({required int userId, required String bookId}) async {
    await (db.delete(db.userBookEntity)
          ..where(($UserBookEntityTable userBook) {
            return userBook.userId.equals(userId) & userBook.bookId.equals(bookId);
          }))
        .go();
  }

  @override
  Stream<List<BookModel>> getUserBookStream({required int userId}) {
    final List<Join<HasResultSet, dynamic>> joins = <Join<HasResultSet, dynamic>>[
      innerJoin(
        db.userBookEntity,
        db.userBookEntity.userId.equals(userId) &
            db.userBookEntity.bookId.equalsExp(db.bookEntity.id),
      ),
      innerJoin(db.bookAuthorEntity, db.bookAuthorEntity.bookId.equalsExp(db.bookEntity.id)),
      innerJoin(db.authorEntity, db.authorEntity.id.equalsExp(db.bookAuthorEntity.authorId)),
    ];

    final JoinedSelectStatement<HasResultSet, dynamic> query = db.select(db.bookEntity).join(joins);

    return query.watch().map((List<TypedResult> rows) => rows.mapToBooks(database: db));
  }
}
