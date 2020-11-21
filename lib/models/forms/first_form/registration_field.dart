import 'package:auto_kobe/models/models.dart';
import 'package:formz/formz.dart';

enum RegistrationFieldValidationError { invalid }

class RegistrationField
    extends FormzInput<Date, RegistrationFieldValidationError> {
  const RegistrationField.pure()
      : super.pure(const Date(day: null, month: null, year: null));
  const RegistrationField.dirty(Date value) : super.dirty(value);

  @override
  RegistrationFieldValidationError validator(Date value) {
    return null;
  }
}
