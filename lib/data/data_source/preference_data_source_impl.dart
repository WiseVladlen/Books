import 'package:books/domain/domain.dart';

const String _userKey = 'user_key';

class PreferenceDataSourceImpl implements IPreferenceDataSource {
  final Map<String, dynamic> _cache = <String, dynamic>{};

  @override
  UserModel? readUser() => _cache[_userKey] as UserModel?;

  @override
  Future<void> writeUser(UserModel? value) async => _cache[_userKey] = value;
}
