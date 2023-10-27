import 'package:books/domain/model/model.dart';

const String _userKey = 'user_key';

class CacheStorage {
  factory CacheStorage() => _instance;

  CacheStorage._();

  static final CacheStorage _instance = CacheStorage._();

  final Map<String, dynamic> _cache = <String, dynamic>{};

  UserModel? readUser() => _cache[_userKey] as UserModel?;

  void writeUser(UserModel? value) => _cache[_userKey] = value;
}
