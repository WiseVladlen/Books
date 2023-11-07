part of '../database.dart';

class UserEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get email => text().unique()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  BoolColumn get isAuthenticated => boolean()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{id, email},
      ];
}

extension UserModelToUserTableCompanionMapper on RegistrationDataModel {
  UserEntityCompanion toUserEntityCompanion() {
    return UserEntityCompanion(
      email: Value<String>(email),
      name: Value<String>(name),
      password: Value<String>(password),
      isAuthenticated: const Value<bool>(false),
    );
  }
}

extension UserEntityDataToUserModelMapper on UserEntityData {
  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      name: name,
    );
  }
}
