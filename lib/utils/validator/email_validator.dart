import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class EmailValidator extends FormzInput<String, EmailValidationError> {
  const EmailValidator.pure() : super.pure('');
  const EmailValidator.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-](([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,})',
  );

  bool get hasError => displayError != null;

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '') ? null : EmailValidationError.invalid;
  }
}
