import 'package:auto_kobe/blocs/blocs.dart';
import 'package:formz/formz.dart';

enum ThirdFormInputValidationError { invalid }

class ThirdFormInput
    extends FormzInput<ThirdFormState, ThirdFormInputValidationError> {
  const ThirdFormInput.pure() : super.pure(const ThirdFormState());
  const ThirdFormInput.dirty(ThirdFormState value) : super.dirty(value);

  @override
  ThirdFormInputValidationError validator(ThirdFormState value) {
    if (!value.valid) return ThirdFormInputValidationError.invalid;
    return null;
  }
}
