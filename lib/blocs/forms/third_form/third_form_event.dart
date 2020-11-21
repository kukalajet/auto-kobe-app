part of 'third_form_bloc.dart';

abstract class ThirdFormEvent extends Equatable {
  const ThirdFormEvent();

  @override
  List<Object> get props => [];
}

class ListingCubicCapacityChanged extends ThirdFormEvent {
  const ListingCubicCapacityChanged(this.cubicCapacity);

  final int cubicCapacity;

  @override
  List<Object> get props => [cubicCapacity];
}

class ListingFuelChanged extends ThirdFormEvent {
  const ListingFuelChanged(this.fuel);

  final FuelType fuel;

  @override
  List<Object> get props => [fuel];
}

class ListingMotorPowerChanged extends ThirdFormEvent {
  const ListingMotorPowerChanged(this.motorPower);

  final int motorPower;

  @override
  List<Object> get props => [motorPower];
}
