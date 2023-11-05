import 'package:books/domain/domain.dart';
import 'package:books/utils/exception/exception.dart';
import 'package:books/utils/validator/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationRepository}) : super(const LoginState());

  final IAuthRepository authenticationRepository;

  void emailChanged(String value) {
    final EmailValidator email = EmailValidator.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final PasswordValidator password = PasswordValidator.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[state.email, password]),
      ),
    );
  }

  Future<void> logIn() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await authenticationRepository.logIn(
        model: LoginDataModel(
          email: state.email.value,
          password: state.password.value,
        ),
      );
    } on LogInFailure {
      return emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
