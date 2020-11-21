import 'package:auto_kobe/blocs/blocs.dart';
import 'package:formz/formz.dart';

enum SecondFormInputValidationError { invalid }

class SecondFormInput
    extends FormzInput<SecondFormState, SecondFormInputValidationError> {
  const SecondFormInput.pure() : super.pure(const SecondFormState());
  const SecondFormInput.dirty(SecondFormState value) : super.dirty(value);

  @override
  SecondFormInputValidationError validator(SecondFormState value) {
    if (!value.valid) return SecondFormInputValidationError.invalid;
    return null;
  }
}
