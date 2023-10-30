import 'package:books/data/database.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

part 'book_author_dao.g.dart';

@DriftAccessor(tables: <Type>[BookAuthorEntity])
class BookAuthorDao extends DatabaseAccessor<Database> with _$BookAuthorDaoMixin {
  BookAuthorDao(Database db) : super(db);

  Future<void> insertBookAuthors({
    required Iterable<BookModel> books,
    required AuthorMap authorMap,
  }) async {
    final Iterable<BookAuthorEntityCompanion> bookAuthors = books
        .map(
          (BookModel book) => book.authors.map(
            (String author) => BookAuthorEntityCompanion(
              authorId: Value<int>(authorMap[author]!.id),
              bookId: Value<String>(book.id),
            ),
          ),
        )
        .expand((Iterable<BookAuthorEntityCompanion> element) => element);

    await db.batch(
      (Batch batch) => batch.insertAll(
        db.bookAuthorEntity,
        bookAuthors,
        mode: InsertMode.insertOrIgnore,
      ),
    );
  }
}
