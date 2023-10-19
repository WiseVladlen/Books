import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/repository/book_repository.dart';

class BookRepository implements IBookRepository {
  @override
  Future<List<BookModel>> getBooks() async {
    return List.generate(
      30,
      (index) => BookModel(
        id: '$index',
        title: 'Pride and Prejudice',
        authors: const ['Jane Austen'],
        publisher: 'Publisher',
        publishedDate: DateTime.now(),
        description:
            'Austen’s most celebrated novel tells the story of Elizabeth Bennet, a bright, lively young woman with four sisters, '
            'and a mother determined to marry them to wealthy men. At a party near the Bennets’ home in the English countryside, '
            'Elizabeth meets the wealthy, proud Fitzwilliam Darcy. '
            'Elizabeth initially finds Darcy haughty and intolerable, but circumstances continue to unite the pair.',
        imageLink:
            'http://books.google.com/books/content?id=s1gVAAAAYAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE70fypJwVAlFWEFWt6x8COgPhJzsdNJhkncql8z6bqKClWENfJX8_IaSEXMGglsnW3Qb1KGvmS1b0Xf9Lu4Si43-VXPUOXXmS6XOjRBi7QpyEjUuCG2QweD_qbcI6A1aLdU0Q3le&source=gbs_api',
        language: 'en',
      ),
    );
  }
}
