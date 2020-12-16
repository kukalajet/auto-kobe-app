import 'package:formz/formz.dart';
import 'package:transmission_repository/transmission_repository.dart';

enum TransmissionFieldValidationError { invalid }

class TransmissionField
    extends FormzInput<Transmission, TransmissionFieldValidationError> {
  const TransmissionField.pure()
      : super.pure(const Transmission(id: null, type: null));
  const TransmissionField.dirty(Transmission value) : super.dirty(value);

  @override
  TransmissionFieldValidationError validator(Transmission value) {
    if (value.id == null && value.type == null)
      return TransmissionFieldValidationError.invalid;

    return null;
  }
}
