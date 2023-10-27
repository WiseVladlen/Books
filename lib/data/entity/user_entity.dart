part of '../database.dart';

@DataClassName('User')
class UserEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  BoolColumn get isAuthenticated => boolean()();
}

extension UserModelToUserTableCompanionMapper on RegistrationDataModel {
  UserEntityCompanion toDatabaseUser() {
    return UserEntityCompanion(
      email: Value<String>(email),
      name: Value<String>(name),
      password: Value<String>(password),
      isAuthenticated: const Value<bool>(false),
    );
  }
}

extension DatabaseUserToUserModelMapper on User {
  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      name: name,
    );
  }
}
