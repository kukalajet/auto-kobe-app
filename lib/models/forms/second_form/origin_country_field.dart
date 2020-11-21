import 'package:formz/formz.dart';
import 'package:country_repository/country_repository.dart';

enum OriginCountryFieldValidationError { invalid }

class OriginCountryField
    extends FormzInput<Country, OriginCountryFieldValidationError> {
  const OriginCountryField.pure()
      : super.pure(const Country(id: null, name: null, image: null));
  const OriginCountryField.dirty(Country value) : super.dirty(value);

  @override
  OriginCountryFieldValidationError validator(Country value) {
    if (value.id == null && value.name == null && value.image == null)
      return OriginCountryFieldValidationError.invalid;

    return null;
  }
}
