import 'package:formz/formz.dart';

enum PriceFieldValidationError { invalid }

class PriceField extends FormzInput<int, PriceFieldValidationError> {
  const PriceField.pure() : super.pure(0);
  const PriceField.dirty(int value) : super.dirty(value);

  @override
  PriceFieldValidationError validator(int value) {
    if (value <= 0) return PriceFieldValidationError.invalid;
    return null;
  }
}
