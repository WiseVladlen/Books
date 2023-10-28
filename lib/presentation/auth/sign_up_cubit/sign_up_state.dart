part of 'sign_up_cubit.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final NameValidator name;
  final EmailValidator email;
  final PasswordValidator password;
  final FormzSubmissionStatus status;
  final bool isValid;

  SignUpState copyWith({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => <Object>[name, email, password, status, isValid];
}
