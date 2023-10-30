part of '../database.dart';

class BookAuthorEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get authorId => integer().named('author_id').references(AuthorEntity, #id)();
  TextColumn get bookId => text().named('book_id').references(BookEntity, #id)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{authorId, bookId},
      ];
}
