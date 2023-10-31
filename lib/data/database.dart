import 'dart:io';

import 'package:books/data/dao/author_dao.dart';
import 'package:books/data/dao/book_author_dao.dart';
import 'package:books/domain/model/model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

part 'entity/author_entity.dart';
part 'entity/book_author_entity.dart';
part 'entity/book_entity.dart';
part 'entity/user_entity.dart';
part 'entity/user_book_entity.dart';

const String _databaseName = 'db.sqlite';

@DriftDatabase(
  tables: <Type>[UserEntity, AuthorEntity, BookEntity, BookAuthorEntity, UserBookEntity],
  daos: <Type>[AuthorDao, BookAuthorDao],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final Directory dbFolder = await getApplicationDocumentsDirectory();
      final File file = File(join(dbFolder.path, _databaseName));
      return NativeDatabase(file);
    });
  }
}
