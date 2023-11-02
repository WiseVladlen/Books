import 'package:books/domain/model/user_model.dart';

abstract interface class IUserRepository {
  Future<UserModel?> getAuthenticatedUserOrNull();
}
