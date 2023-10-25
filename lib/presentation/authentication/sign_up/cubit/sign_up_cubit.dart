import 'package:books/domain/domain.dart';
import 'package:books/presentation/authentication/sign_up/cubit/cubit.dart';
import 'package:books/utils/form/form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationRepository}) : super(const SignUpState());

  final IAuthenticationRepository authenticationRepository;

  void nameChanged(String value) {
    final Name name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[name, state.email, state.password]),
      ),
    );
  }

  void emailChanged(String value) {
    final Email email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput<String, dynamic>>[state.name, email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(value);
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
