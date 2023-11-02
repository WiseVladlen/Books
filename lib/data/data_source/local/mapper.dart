import 'package:books/data/database.dart';
import 'package:books/domain/model/model.dart';
import 'package:drift/drift.dart';

extension JoinedSelectStatementMapper on List<TypedResult> {
  /// The current elements of this iterable are converted into a list of books
  List<BookModel> mapToBooks({required Database database}) {
    final Iterable<BookEntityData> bookEntity = map(
      (TypedResult e) => e.readTable(database.bookEntity),
    );

    final Iterable<AuthorEntityData> authorEntity = map(
      (TypedResult e) => e.readTable(database.authorEntity),
    );

    final Iterable<BookAuthorEntityData> bookAuthorEntity = map(
      (TypedResult e) => e.readTable(database.bookAuthorEntity),
    );

    final Iterable<BookModel> books = bookEntity.map((BookEntityData book) {
      final Iterable<int> authorIds = bookAuthorEntity
          .where((BookAuthorEntityData bookAuthor) => bookAuthor.bookId == book.id)
          .map((BookAuthorEntityData bookAuthor) => bookAuthor.authorId);

      final Iterable<AuthorEntityData> authors = authorEntity.where(
        (AuthorEntityData author) => authorIds.contains(author.id),
      );

      return (book: book, authors: authors).model;
    });

    // FIXME: Using join, redundant equivalent entries are mapped to books with multiple authors
    return books.toSet().toList(growable: false);
  }
}
