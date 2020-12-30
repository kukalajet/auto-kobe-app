import 'package:formz/formz.dart';
import 'package:model_repository/model_repository.dart';

enum ModelFieldValidationError { invalid }

class ModelField extends FormzInput<Model, ModelFieldValidationError> {
  const ModelField.pure() : super.pure(const Model(id: null, name: null));
  const ModelField.dirty(Model value) : super.dirty(value);

  @override
  ModelFieldValidationError validator(Model value) => null;
}
