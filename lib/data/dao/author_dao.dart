import 'package:books/data/database.dart';
import 'package:drift/drift.dart';

part 'author_dao.g.dart';

@DriftAccessor(tables: <Type>[AuthorEntity])
class AuthorDao extends DatabaseAccessor<Database> with _$AuthorDaoMixin {
  AuthorDao(Database db) : super(db);

  /// Inserts rows into the table and returns them in the [AuthorMap] format.
  Future<AuthorMap> insertAllReturning(Iterable<String> authors) async {
    final AuthorMap result = <String, AuthorEntityData>{};
    for (final String author in authors) {
      final AuthorEntityData? authorEntityOrNull = await into(authorEntity).insertReturningOrNull(
        AuthorEntityCompanion(name: Value<String>(author)),
        mode: InsertMode.insertOrIgnore,
      );

      late final Future<AuthorEntityData> nonNullAuthorEntity = (select(authorEntity)
            ..where(($AuthorEntityTable entity) => entity.name.equals(author)))
          .getSingle();

      result[author] = authorEntityOrNull ?? await nonNullAuthorEntity;
    }
    return result;
  }
}
