import 'dart:async';

import 'package:auto_kobe/models/forms/forms.dart';
import 'package:auto_kobe/models/models.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:model_repository/model_repository.dart';

part 'first_form_event.dart';
part 'first_form_state.dart';

class FirstFormBloc extends Bloc<FirstFormEvent, FirstFormState> {
  FirstFormBloc() : super(const FirstFormState());

  @override
  Stream<FirstFormState> mapEventToState(
    FirstFormEvent event,
  ) async* {
    if (event is ListingBrandChanged) {
      yield _mapBrandChangedToState(event, state);
    } else if (event is ListingModelChanged) {
      yield _mapModelChangedToState(event, state);
    } else if (event is ListingPriceChanged) {
      yield _mapPriceChangedToState(event, state);
    } else if (event is ListingRegistrationChanged) {
      _mapRegistrationChangedToState(event, state);
    }
  }

  FirstFormState _mapBrandChangedToState(
    ListingBrandChanged event,
    FirstFormState state,
  ) {
    final brand = BrandField.dirty(event.brand);
    return state.copyWith(
        brand: brand,
        status: Formz.validate([
          brand,
          state.model,
          state.registration,
          state.price,
        ]));
  }

  FirstFormState _mapModelChangedToState(
    ListingModelChanged event,
    FirstFormState state,
  ) {
    final model = ModelField.dirty(event.model);
    return state.copyWith(
        model: model,
        status: Formz.validate([
          state.brand,
          model,
          state.registration,
          state.price,
        ]));
  }

  FirstFormState _mapRegistrationChangedToState(
    ListingRegistrationChanged event,
    FirstFormState state,
  ) {
    final registration = RegistrationField.dirty(event.registration);
    return state.copyWith(
        registration: registration,
        status: Formz.validate([
          state.brand,
          state.model,
          registration,
          state.price,
        ]));
  }

  // FirstFormState _mapMileageChangedToState(
  //   ListingMileageChanged event,
  //   FirstFormState state,
  // ) {
  //   final mileage = MileageField.dirty(event.mileage);
  //   return state.copyWith(
  //       mileage: mileage,
  //       status: Formz.validate([
  //         state.brand,
  //         state.model,
  //         state.registration,
  //         mileage,
  //       ]));
  // }

  FirstFormState _mapPriceChangedToState(
    ListingPriceChanged event,
    FirstFormState state,
  ) {
    final price = PriceField.dirty(event.price);
    return state.copyWith(
        // mileage: mileage,
        price: price,
        status: Formz.validate([
          state.brand,
          state.model,
          state.registration,
          price,
        ]));
  }

  // Stream<FirstFormState> _mapFirstFormSubmittedToState(
  //   ListingFirstFormSubmitted event,
  //   FirstFormState state,
  // ) async* {
  //   yield state.copyWith(status: FormzStatus.submissionSuccess);
  // }
}
