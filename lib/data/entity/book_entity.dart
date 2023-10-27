part of '../database.dart';

@DataClassName('Book')
class BookEntity extends Table {
  @override
  Set<Column<Object>> get primaryKey => <TextColumn>{id};

  TextColumn get id => text()();
  TextColumn get title => text()();

  TextColumn get authors => text().map(const ListConverter<String>())();

  IntColumn get pageCount => integer().nullable()();
  TextColumn get publisher => text().withDefault(const Constant<String>(''))();
  DateTimeColumn get publishedDate => dateTime().nullable()();
  TextColumn get description => text().withDefault(const Constant<String>(''))();
  TextColumn get imageLink => text().withDefault(const Constant<String>(''))();
  TextColumn get language => text()();
}
