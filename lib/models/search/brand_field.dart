import 'package:brand_repository/brand_repository.dart';
import 'package:formz/formz.dart';

enum BrandFieldValidationError { invalid }

class BrandField extends FormzInput<Brand, BrandFieldValidationError> {
  const BrandField.pure() : super.pure(const Brand(id: null, name: null));
  const BrandField.dirty(Brand value) : super.dirty(value);

  @override
  BrandFieldValidationError validator(Brand value) => null;
}
