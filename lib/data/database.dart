import 'dart:io';

import 'package:books/data/data.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'entity/book_entity.dart';
part 'entity/user_entity.dart';

part 'database.g.dart';

const String _databaseName = 'db.sqlite';

@DriftDatabase(tables: <Type>[UserEntity, BookEntity])
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
