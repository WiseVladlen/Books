import 'package:books/domain/model/model.dart';

abstract interface class IUserLocalDataSource {
  Future<UserModel?> getAuthenticatedUserOrNull();
}
