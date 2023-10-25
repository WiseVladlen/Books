import 'package:books/utils/form/form.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid];
}
