import 'package:formz/formz.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';

enum FuelFieldValidationError { invalid }

class FuelField extends FormzInput<FuelType, FuelFieldValidationError> {
  const FuelField.pure() : super.pure(const FuelType(id: null, type: null));
  const FuelField.dirty(FuelType value) : super.dirty(value);

  @override
  FuelFieldValidationError validator(FuelType value) {
    if (value.id == null && value.type == null) {
      return FuelFieldValidationError.invalid;
    }

    return null;
  }
}
