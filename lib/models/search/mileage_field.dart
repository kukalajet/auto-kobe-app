import 'package:formz/formz.dart';

enum MileageFieldValidationError { invalid }

class MileageField
    extends FormzInput<List<double>, MileageFieldValidationError> {
  const MileageField.pure()
      : super.pure(const <double>[/*0, double.infinity*/]);
  const MileageField.dirty(List<double> value) : super.dirty(value);

  @override
  MileageFieldValidationError validator(List<double> value) => null;
}
