import 'package:books/domain/domain.dart';
import 'package:books/utils/validator/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationRepository}) : super(const SignUpState());

  final IAuthRepository authenticationRepository;

  void nameChanged(String value) {
    final NameValidator name = NameValidator.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[name, state.email, state.password]),
      ),
    );
  }

  void emailChanged(String value) {
    final EmailValidator email = EmailValidator.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[state.name, email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final PasswordValidator password = PasswordValidator.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[state.name, state.email, password]),
      ),
    );
  }

  Future<void> signUp() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    // TODO
    await authenticationRepository.signUp(
      model: RegistrationDataModel(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      ),
    );

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
