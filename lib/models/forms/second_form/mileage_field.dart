import 'package:formz/formz.dart';

enum MileageFieldValidationError { invalid }

class MileageField extends FormzInput<int, MileageFieldValidationError> {
  const MileageField.pure() : super.pure(0);
  const MileageField.dirty(int value) : super.dirty(value);

  @override
  MileageFieldValidationError validator(int value) {
    if (value <= 0) return MileageFieldValidationError.invalid;
    return null;
  }
}
