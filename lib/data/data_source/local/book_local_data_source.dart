import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:drift/drift.dart';

class BookLocalDataSourceImpl implements IBookLocalDataSource {
  const BookLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<void> upsertBooks(List<BookModel> books) async {
    await db.batch(
      (Batch batch) => batch.insertAll(
        db.bookEntity,
        books.map((BookModel e) => e.toDatabaseBook()),
        mode: InsertMode.replace,
      ),
    );
  }
}
