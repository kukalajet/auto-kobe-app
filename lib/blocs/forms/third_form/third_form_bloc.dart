import 'dart:async';

import 'package:auto_kobe/models/forms/forms.dart';
import 'package:auto_kobe/models/forms/third_form/images_field.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:emission_repository/emission_repository.dart';

part 'third_form_event.dart';
part 'third_form_state.dart';

class ThirdFormBloc extends Bloc<ThirdFormEvent, ThirdFormState> {
  ThirdFormBloc() : super(const ThirdFormState());

  @override
  Stream<ThirdFormState> mapEventToState(
    ThirdFormEvent event,
  ) async* {
    if (event is ListingCubicCapacityChanged) {
      yield _mapCubicCapacityChangedToState(event, state);
    } else if (event is ListingFuelChanged) {
      yield _mapFuelChangedToState(event, state);
    } else if (event is ListingMotorPowerChanged) {
      yield _mapMotorPowerChangedToState(event, state);
    } else if (event is ListingEmissionChanged) {
      yield _mapEmissionChangedToState(event, state);
    } else if (event is ListingImagesChanged) {
      yield _mapImagesChangedToState(event, state);
    }
  }

  ThirdFormState _mapCubicCapacityChangedToState(
    ListingCubicCapacityChanged event,
    ThirdFormState state,
  ) {
    final cubicCapacity = CubicCapacityField.dirty(event.cubicCapacity);
    return state.copyWith(
      cubicCapacity: cubicCapacity,
      status: Formz.validate([
        cubicCapacity,
        state.fuel,
        state.motorPower,
        state.emission,
        state.images,
      ]),
    );
  }

  ThirdFormState _mapFuelChangedToState(
    ListingFuelChanged event,
    ThirdFormState state,
  ) {
    final fuel = FuelField.dirty(event.fuel);
    return state.copyWith(
      fuel: fuel,
      status: Formz.validate([
        state.cubicCapacity,
        fuel,
        state.motorPower,
        state.emission,
        state.images,
      ]),
    );
  }

  ThirdFormState _mapMotorPowerChangedToState(
    ListingMotorPowerChanged event,
    ThirdFormState state,
  ) {
    final motorPower = MotorPowerField.dirty(event.motorPower);
    return state.copyWith(
      motorPower: motorPower,
      status: Formz.validate([
        state.cubicCapacity,
        state.fuel,
        motorPower,
        state.emission,
        state.images,
      ]),
    );
  }

  ThirdFormState _mapEmissionChangedToState(
    ListingEmissionChanged event,
    ThirdFormState state,
  ) {
    final emission = EmissionField.dirty(event.emission);
    return state.copyWith(
      emission: emission,
      status: Formz.validate([
        state.cubicCapacity,
        state.fuel,
        state.motorPower,
        emission,
        state.images,
      ]),
    );
  }

  ThirdFormState _mapImagesChangedToState(
    ListingImagesChanged event,
    ThirdFormState state,
  ) {
    final images = ImagesField.dirty(event.images);
    return state.copyWith(
      images: images,
      status: Formz.validate([
        state.cubicCapacity,
        state.fuel,
        state.motorPower,
        state.emission,
        images,
      ]),
    );
  }
}
