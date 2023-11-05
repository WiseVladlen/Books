import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

class UserLocalDataSourceImpl implements IUserLocalDataSource {
  const UserLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<UserModel?> getAuthenticatedUserOrNull() async {
    final SimpleSelectStatement<$UserEntityTable, UserEntityData> query = db.select(db.userEntity)
      ..where(($UserEntityTable user) => user.isAuthenticated.equals(true));

    return (await query.get()).firstOrNull?.toUserModel();
  }
}
