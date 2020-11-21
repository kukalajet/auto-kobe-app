import 'dart:async';

import 'package:auto_kobe/models/forms/forms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';

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
      ]),
    );
  }
}
