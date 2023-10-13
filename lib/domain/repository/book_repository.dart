import 'package:books/domain/model/book_model.dart';

abstract interface class IBookRepository {
  List<BookModel> getAll();
}
