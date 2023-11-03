abstract interface class IFavoritesRepository {
  Future<void> addBook({required String bookId});
  Future<void> deleteBook({required String bookId});
}
