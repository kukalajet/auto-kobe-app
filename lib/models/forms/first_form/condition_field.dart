import 'package:formz/formz.dart';
import 'package:condition_repository/condition_repository.dart';

enum ConditionFieldValidationError { invalid }

class ConditionField
    extends FormzInput<Condition, ConditionFieldValidationError> {
  const ConditionField.pure()
      : super.pure(const Condition(id: null, type: null));
  const ConditionField.dirty(Condition value) : super.dirty(value);

  @override
  ConditionFieldValidationError validator(Condition value) {
    if (value.id == null && value.type == null) {
      return ConditionFieldValidationError.invalid;
    }

    return null;
  }
}
