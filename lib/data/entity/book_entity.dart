part of '../database.dart';

class BookEntity extends Table {
  @override
  Set<Column<Object>> get primaryKey => <TextColumn>{id};

  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get pageCount => integer().nullable()();
  TextColumn get publisher => text().withDefault(const Constant<String>(''))();
  DateTimeColumn get publishedDate => dateTime().nullable()();
  TextColumn get description => text().withDefault(const Constant<String>(''))();
  TextColumn get imageLink => text().withDefault(const Constant<String>(''))();
  TextColumn get language => text()();
}

typedef BookWithAuthors = ({
  BookEntityData book,
  Iterable<AuthorEntityData> authors,
});

extension BookModelToBookEntityDataMapper on BookModel {
  BookEntityData get entity => BookEntityData(
        id: id,
        title: title,
        pageCount: pageCount,
        publisher: publisher,
        publishedDate: publishedDate,
        description: description,
        imageLink: imageLink,
        language: language,
      );
}

extension BookWithAuthorsToBookModelMapper on BookWithAuthors {
  BookModel get model => BookModel(
        id: book.id,
        title: book.title,
        authors: authors.map((AuthorEntityData author) => author.name).toList(growable: false),
        pageCount: book.pageCount,
        publisher: book.publisher,
        publishedDate: book.publishedDate,
        description: book.description,
        imageLink: book.imageLink,
        language: book.language,
      );
}
