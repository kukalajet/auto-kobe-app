import 'package:formz/formz.dart';
import 'package:valute_repository/valute_repository.dart';

enum PriceFieldValidationError { invalid }

class PriceField extends FormzInput<List<Price>, PriceFieldValidationError> {
  const PriceField.pure() : super.pure(const <Price>[]);
  const PriceField.dirty(List<Price> value) : super.dirty(value);

  @override
  PriceFieldValidationError validator(List<Price> value) => null;
}
