import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

class UserLocalDataSourceImpl implements IUserLocalDataSource {
  const UserLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<UserModel?> getAuthenticatedUser() async {
    final SimpleSelectStatement<$UserEntityTable, User> query = db.select(db.userEntity)
      ..where(($UserEntityTable user) => user.isAuthenticated.equals(true));

    return (await query.getSingleOrNull())?.toUserModel();
  }
}
