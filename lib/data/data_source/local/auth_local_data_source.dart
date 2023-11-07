import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

class AuthLocalDataSourceImpl implements IAuthLocalDataSource {
  const AuthLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<bool> signUp({required RegistrationDataModel data}) async {
    final UserEntityData? user = await db.into(db.userEntity).insertReturningOrNull(
          data.toUserEntityCompanion(),
          mode: InsertMode.insertOrIgnore,
        );

    return user != null;
  }

  @override
  Future<UserModel?> logIn({required LoginDataModel data}) async {
    final Future<List<UserEntityData>> result = (db.update(db.userEntity)
          ..where(
            ($UserEntityTable user) {
              return user.email.equals(data.email) & user.password.equals(data.password);
            },
          ))
        .writeReturning(const UserEntityCompanion(isAuthenticated: Value<bool>(true)));

    return (await result).firstOrNull?.toUserModel();
  }

  @override
  Future<void> logOut({required int id}) async {
    await (db.update(db.userEntity)..where(($UserEntityTable user) => user.id.equals(id)))
        .write(const UserEntityCompanion(isAuthenticated: Value<bool>(false)));
  }
}
