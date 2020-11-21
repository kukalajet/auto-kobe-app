import 'package:auto_kobe/blocs/blocs.dart';
import 'package:formz/formz.dart';

enum FirstFormInputValidationError { invalid }

class FirstFormInput
    extends FormzInput<FirstFormState, FirstFormInputValidationError> {
  const FirstFormInput.pure() : super.pure(const FirstFormState());
  const FirstFormInput.dirty(FirstFormState value) : super.dirty(value);

  @override
  FirstFormInputValidationError validator(FirstFormState value) {
    if (!value.valid) return FirstFormInputValidationError.invalid;
    return null;
  }
}
