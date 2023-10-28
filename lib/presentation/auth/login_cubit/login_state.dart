part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final EmailValidator email;
  final PasswordValidator password;
  final FormzSubmissionStatus status;
  final bool isValid;

  LoginState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
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
  List<Object> get props => <Object>[email, password, status, isValid];
}
