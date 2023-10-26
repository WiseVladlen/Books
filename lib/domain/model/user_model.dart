import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  final int id;
  final String email;
  final String name;

  @override
  List<Object> get props => <Object>[id, email, name];
}
