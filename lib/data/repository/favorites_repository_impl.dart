import 'package:books/domain/domain.dart';

class FavoritesRepositoryImpl implements IFavoritesRepository {
  const FavoritesRepositoryImpl({
    required this.bookLocalDataSource,
    required this.preferenceDataSource,
  });

  final IBookLocalDataSource bookLocalDataSource;

  final IPreferenceDataSource preferenceDataSource;

  @override
  Future<void> addBook({required String bookId}) {
    final UserModel? user = preferenceDataSource.readUser();
    return user != null
        ? bookLocalDataSource.addBookToFavourites(userId: user.id, bookId: bookId)
        : Future<void>.error(Exception('Authenticated user was null'));
  }

  @override
  Future<void> deleteBook({required String bookId}) {
    final UserModel? user = preferenceDataSource.readUser();
    return user != null
        ? bookLocalDataSource.deleteBookFromFavourites(userId: user.id, bookId: bookId)
        : Future<void>.error(Exception('Authenticated user was null'));
  }
}
