part of '../database.dart';

@DataClassName('User')
class UserEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  BoolColumn get isAuthenticated => boolean()();
}
