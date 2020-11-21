import 'package:formz/formz.dart';
import 'package:door_type_repository/door_type_repository.dart';

enum DoorsFieldValidationError { invalid }

// TODO: Rename to DoorTypeField.
class DoorsField extends FormzInput<DoorType, DoorsFieldValidationError> {
  const DoorsField.pure() : super.pure(const DoorType(id: null, number: null));
  const DoorsField.dirty(DoorType value) : super.dirty(value);

  @override
  DoorsFieldValidationError validator(DoorType value) {
    if (value.id == null && value.number == null)
      return DoorsFieldValidationError.invalid;

    return null;
  }
}
