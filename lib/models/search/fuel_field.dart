import 'package:formz/formz.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';

enum FuelFieldValidationError { invalid }

class FuelField extends FormzInput<Fuel, FuelFieldValidationError> {
  const FuelField.pure() : super.pure(const Fuel(id: null, type: null));
  const FuelField.dirty(Fuel value) : super.dirty(value);

  @override
  FuelFieldValidationError validator(Fuel value) => null;
}
