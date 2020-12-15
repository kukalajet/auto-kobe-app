import 'package:formz/formz.dart';
import 'package:valute_repository/valute_repository.dart';

enum PriceFieldValidationError { invalid }

class PriceField extends FormzInput<Price, PriceFieldValidationError> {
  const PriceField.pure() : super.pure(const Price(value: null, valute: null));
  const PriceField.dirty(Price value) : super.dirty(value);

  @override
  PriceFieldValidationError validator(Price value) {
    if (value.value == null || value.valute == null)
      return PriceFieldValidationError.invalid;

    return null;
  }
}
