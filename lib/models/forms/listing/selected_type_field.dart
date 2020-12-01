import 'package:formz/formz.dart';
import 'package:listing_repository/listing_repository.dart';

enum SelectedTypeFieldValidationError { invalid }

class SelectedTypeField
    extends FormzInput<SearchType, SelectedTypeFieldValidationError> {
  const SelectedTypeField.pure()
      : super.pure(const SearchType(id: null, title: null));
  const SelectedTypeField.dirty(SearchType value) : super.dirty(value);

  @override
  SelectedTypeFieldValidationError validator(SearchType value) {
    if (value.id == null || value.title == null)
      return SelectedTypeFieldValidationError.invalid;
    return null;
  }
}
