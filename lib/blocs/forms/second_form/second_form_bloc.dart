import 'dart:async';

import 'package:auto_kobe/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:country_repository/country_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';

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
      ]),
    );
  }

  // SecondFormState _mapSeatsChangedToState(
  //   ListingSeatsChanged event,
  //   SecondFormState state,
  // ) {
  //   final seats = SeatsField.dirty(event.seats);
  //   return state.copyWith(
  //     seats: seats,
  //     status: Formz.validate([
  //       state.country,
  //       state.doors,
  //       seats,
  //     ]),
  //   );
  // }

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
      ]),
    );
  }
}
