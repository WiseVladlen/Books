import 'dart:convert';
import 'package:drift/drift.dart';

class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String? fromDb) {
    return fromDb == null ? <T>[] : List<T>.from(json.decode(fromDb) as Iterable<T>);
  }

  @override
  String toSql(List<T> value) => json.encode(value);
}
