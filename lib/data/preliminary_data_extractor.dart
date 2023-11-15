import 'package:books/domain/repository/repository_storage.dart';

abstract class PreliminaryDataExtractor {
  /// Retrieves the pre-initialization data that will be needed to start the application.
  static Future<void> run({required RepositoryStorage repositoryStorage}) async {
    await repositoryStorage.userRepository.fetchAuthenticatedUser();
  }
}
