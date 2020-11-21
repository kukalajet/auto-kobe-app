import 'package:formz/formz.dart';

enum SeatsFieldValidationError { invalid }

class SeatsField extends FormzInput<int, SeatsFieldValidationError> {
  const SeatsField.pure() : super.pure(0);
  const SeatsField.dirty(int value) : super.dirty(value);

  @override
  SeatsFieldValidationError validator(int value) {
    if (value <= 0) return SeatsFieldValidationError.invalid;
    return null;
  }
}
