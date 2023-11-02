abstract interface class IFavoritesRepository {
  Future<void> addBook({required int userId, required String bookId});
  Future<void> deleteBook({required int userId, required String bookId});
}
