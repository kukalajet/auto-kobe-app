import 'package:formz/formz.dart';

enum SurnameValidationError { invalid }

class Surname extends FormzInput<String, SurnameValidationError> {
  const Surname.pure() : super.pure('');
  const Surname.dirty([String value = '']) : super.dirty(value);

  @override
  SurnameValidationError validator(String value) {
    return null;
  }
}
