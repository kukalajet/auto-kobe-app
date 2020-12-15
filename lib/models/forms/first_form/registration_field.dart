import 'package:formz/formz.dart';
import 'package:listing_repository/listing_repository.dart';

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
