import 'package:books/domain/domain.dart';

class FavoritesRepositoryImpl implements IFavoritesRepository {
  const FavoritesRepositoryImpl({required this.bookLocalDataSource});

  final IBookLocalDataSource bookLocalDataSource;

  @override
  Future<void> addBook({required int userId, required String bookId}) {
    return bookLocalDataSource.addBookToFavourites(userId: userId, bookId: bookId);
  }

  @override
  Future<void> deleteBook({required int userId, required String bookId}) {
    return bookLocalDataSource.deleteBookFromFavourites(userId: userId, bookId: bookId);
  }
}
