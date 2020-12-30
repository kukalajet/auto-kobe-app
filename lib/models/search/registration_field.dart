import 'package:formz/formz.dart';
import 'package:listing_repository/listing_repository.dart';

enum RegistrationFieldValidationError { invalid }

class RegistrationField
    extends FormzInput<List<Date>, RegistrationFieldValidationError> {
  const RegistrationField.pure() : super.pure(const <Date>[]);
  const RegistrationField.dirty(List<Date> value) : super.dirty(value);

  @override
  RegistrationFieldValidationError validator(List<Date> value) => null;
}
