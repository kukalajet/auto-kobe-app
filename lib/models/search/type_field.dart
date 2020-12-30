import 'package:formz/formz.dart';
import 'package:auto_kobe/models/models.dart';

enum TypeFieldValidationError { invalid }

class TypeField extends FormzInput<Type, TypeFieldValidationError> {
  const TypeField.pure() : super.pure(const Type(id: null, name: null));
  const TypeField.dirty(Type value) : super.dirty(value);

  @override
  TypeFieldValidationError validator(Type type) => null;
}
