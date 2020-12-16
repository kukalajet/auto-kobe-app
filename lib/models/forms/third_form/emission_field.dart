import 'package:formz/formz.dart';
import 'package:emission_repository/emission_repository.dart';

enum EmissionFieldValidationError { invalid }

class EmissionField extends FormzInput<Emission, EmissionFieldValidationError> {
  const EmissionField.pure()
      : super.pure(const Emission(id: null, standard: null, tier: null));
  const EmissionField.dirty(Emission value) : super.dirty(value);

  @override
  EmissionFieldValidationError validator(Emission value) {
    if (value.id == null && value.standard == null && value.tier == null) {
      return EmissionFieldValidationError.invalid;
    }

    return null;
  }
}
