part of '../database.dart';

class UserBookEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().named('user_id').references(UserEntity, #id)();
  TextColumn get bookId => text().named('book_id').references(BookEntity, #id)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{userId, bookId},
      ];
}
