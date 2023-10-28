import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class NameValidator extends FormzInput<String, NameValidationError> {
  const NameValidator.pure() : super.pure('');
  const NameValidator.dirty([super.value = '']) : super.dirty();

  bool get hasError => displayError != null;

  @override
  NameValidationError? validator(String? value) {
    return (value == null || (value.trim().isNotEmpty && value.trim().length > 1))
        ? null
        : NameValidationError.invalid;
  }
}
