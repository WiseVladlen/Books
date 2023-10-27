import 'package:books/domain/domain.dart';
import 'package:books/utils/form/form.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationRepository}) : super(const LoginState());

  final IAuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final Email email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(value);
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

    // TODO
    await authenticationRepository.logIn(
      model: LoginDataModel(
        email: state.email.value,
        password: state.password.value,
      ),
    );

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
