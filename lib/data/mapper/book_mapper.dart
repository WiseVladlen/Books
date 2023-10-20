import 'package:books/data/dto/book_dto.dart';
import 'package:books/domain/model/book_model.dart';

extension BookDTOToBookModelMapper on BookDTO {
  BookModel toBookModel() {
    final String? publishedDate = volumeInfo.publishedDate;

    return BookModel(
      id: id,
      title: volumeInfo.title,
      authors: volumeInfo.authors,
      pageCount: volumeInfo.pageCount,
      publisher: volumeInfo.publisher,
      publishedDate: publishedDate != null ? DateTime.tryParse(publishedDate) : null,
      description: volumeInfo.description,
      imageLink: volumeInfo.imageLinks?.thumbnail,
      language: volumeInfo.language,
    );
  }
}
