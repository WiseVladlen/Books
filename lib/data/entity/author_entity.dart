part of '../database.dart';

class AuthorEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();
}

/// Defines a map of authors, where the key is the author's unique name
typedef AuthorMap = Map<String, AuthorEntityData>;
