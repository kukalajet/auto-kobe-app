import 'dart:async';

import 'package:auto_kobe/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:country_repository/country_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:transmission_repository/transmission_repository.dart';

part 'second_form_event.dart';
part 'second_form_state.dart';

class SecondFormBloc extends Bloc<SecondFormEvent, SecondFormState> {
  SecondFormBloc() : super(const SecondFormState());

  @override
  Stream<SecondFormState> mapEventToState(
    SecondFormEvent event,
  ) async* {
    if (event is ListingCountryChanged) {
      yield _mapCountryChangedToState(event, state);
    } else if (event is ListingDoorsChanged) {
      yield _mapDoorsChangedToState(event, state);
    } else if (event is ListingMileageChanged) {
      yield _mapMileageChangedToState(event, state);
    } else if (event is ListingTransmissionChanged) {
      yield _mapTransmissionChangedToState(event, state);
    }
  }

  SecondFormState _mapCountryChangedToState(
    ListingCountryChanged event,
    SecondFormState state,
  ) {
    final country = OriginCountryField.dirty(event.country);
    return state.copyWith(
      country: country,
      status: Formz.validate([
        country,
        state.doors,
        state.mileage,
        state.transmission,
      ]),
    );
  }

  SecondFormState _mapDoorsChangedToState(
    ListingDoorsChanged event,
    SecondFormState state,
  ) {
    final doors = DoorsField.dirty(event.doors);
    return state.copyWith(
      doors: doors,
      status: Formz.validate([
        state.country,
        doors,
        state.mileage,
        state.transmission,
      ]),
    );
  }

  SecondFormState _mapMileageChangedToState(
    ListingMileageChanged event,
    SecondFormState state,
  ) {
    final mileage = MileageField.dirty(event.mileage);
    return state.copyWith(
      mileage: mileage,
      status: Formz.validate([
        state.country,
        state.doors,
        mileage,
        state.transmission,
      ]),
    );
  }

  SecondFormState _mapTransmissionChangedToState(
    ListingTransmissionChanged event,
    SecondFormState state,
  ) {
    final transmission = TransmissionField.dirty(event.transmission);
    return state.copyWith(
      transmission: transmission,
      status: Formz.validate([
        state.country,
        state.doors,
        state.mileage,
        transmission,
      ]),
    );
  }
}
