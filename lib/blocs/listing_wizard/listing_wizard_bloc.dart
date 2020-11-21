import 'dart:async';

import 'package:auto_kobe/blocs/forms/second_form/second_form_bloc.dart';
import 'package:auto_kobe/models/forms/forms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// TESTING
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/models/models.dart';

part 'listing_wizard_event.dart';
part 'listing_wizard_state.dart';

class ListingWizardBloc extends Bloc<ListingWizardEvent, ListingWizardState> {
  ListingWizardBloc() : super(ListingWizardInitial());

  @override
  Stream<ListingWizardState> mapEventToState(
    ListingWizardEvent event,
  ) async* {
    if (event is ListingTypeChanged) {
      yield _mapTypeChangedToState(event, state);
    } else if (event is FirstFormStateChanged) {
      yield _mapFirstFormChangedToState(event, state);
    } else if (event is SecondFormStateChanged) {
      yield _mapSecondFormChangedToState(event, state);
    } else if (event is ListingFormSubmitted) {
      yield* _mapFormSubmimttedToState(event, state);
    }
  }

  ListingWizardState _mapTypeChangedToState(
    ListingTypeChanged event,
    ListingWizardState state,
  ) {
    final type = TypeField.dirty(event.type);
    return state.copyWith(
      type: type,
      status: Formz.validate([
        type,
        state.firstForm,
        state.secondForm,
      ]),
    );
  }

  ListingWizardState _mapFirstFormChangedToState(
    FirstFormStateChanged event,
    ListingWizardState state,
  ) {
    final firstForm = FirstFormInput.dirty(event.state);
    return state.copyWith(
      firstForm: firstForm,
      status: Formz.validate([
        state.type,
        firstForm,
        state.secondForm,
      ]),
    );
  }

  ListingWizardState _mapSecondFormChangedToState(
    SecondFormStateChanged event,
    ListingWizardState state,
  ) {
    final secondForm = SecondFormInput.dirty(event.state);
    return state.copyWith(
      secondForm: secondForm,
      status: Formz.validate([
        state.type,
        state.firstForm,
        secondForm,
      ]),
    );
  }

  Stream<ListingWizardState> _mapFormSubmimttedToState(
    ListingFormSubmitted event,
    ListingWizardState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionSuccess);
  }
}
