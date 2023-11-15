import 'package:books/domain/model/user_model.dart';

abstract interface class IUserRepository {
  UserModel? get authenticatedUserOrNull;

  Future<void> fetchAuthenticatedUser();
}
