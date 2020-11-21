import 'package:formz/formz.dart';

enum MotorPowerFieldValidationError { invalid }

class MotorPowerField extends FormzInput<int, MotorPowerFieldValidationError> {
  const MotorPowerField.pure() : super.pure(0);
  const MotorPowerField.dirty(int value) : super.dirty(value);

  @override
  MotorPowerFieldValidationError validator(int value) {
    if (value <= 0) return MotorPowerFieldValidationError.invalid;
    return null;
  }
}
