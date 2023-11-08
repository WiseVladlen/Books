import 'package:books/data/database.dart';
import 'package:books/domain/model/model.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

extension JoinedSelectStatementMapper on List<TypedResult> {
  /// The current elements of this iterable are converted into a list of books
  Set<BookModel> mapToBooks({required Database database}) {
    final Set<AuthorEntityData> authorSet = map(
      (TypedResult typedResult) => typedResult.readTable(database.authorEntity),
    ).toSet();

    final Map<String, Set<BookAuthorEntityData>> bookAuthorsMap = map(
      (TypedResult typedResult) => typedResult.readTable(database.bookAuthorEntity),
    ).groupSetsBy((BookAuthorEntityData bookAuthor) => bookAuthor.bookId);

    final Iterable<BookModel> books = map((TypedResult typedResult) {
      final BookEntityData book = typedResult.readTable(database.bookEntity);
      final Set<BookAuthorEntityData>? bookAuthors = bookAuthorsMap[book.id];

      if (bookAuthors == null || bookAuthors.isEmpty) {
        return (book: book, authors: <AuthorEntityData>[]).model;
      }

      final Iterable<int> authorIds = bookAuthors.map(
        (BookAuthorEntityData bookAuthor) => bookAuthor.authorId,
      );

      final Iterable<AuthorEntityData> authors = authorSet.where(
        (AuthorEntityData author) => authorIds.contains(author.id),
      );

      return (book: book, authors: authors).model;
    });

    return books.toSet();
  }
}
