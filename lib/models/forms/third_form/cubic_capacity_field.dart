import 'package:formz/formz.dart';

enum CubicCapacityFieldValidationError { invalid }

class CubicCapacityField
    extends FormzInput<int, CubicCapacityFieldValidationError> {
  const CubicCapacityField.pure() : super.pure(0);
  const CubicCapacityField.dirty(int value) : super.dirty(value);

  @override
  CubicCapacityFieldValidationError validator(int value) {
    if (value <= 0) return CubicCapacityFieldValidationError.invalid;
    return null;
  }
}
