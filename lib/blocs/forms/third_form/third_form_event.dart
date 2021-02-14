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

  final Fuel fuel;

  @override
  List<Object> get props => [fuel];
}

class ListingMotorPowerChanged extends ThirdFormEvent {
  const ListingMotorPowerChanged(this.motorPower);

  final int motorPower;

  @override
  List<Object> get props => [motorPower];
}

class ListingEmissionChanged extends ThirdFormEvent {
  const ListingEmissionChanged(this.emission);

  final Emission emission;

  @override
  List<Object> get props => [emission];
}

class ListingImagesChanged extends ThirdFormEvent {
  const ListingImagesChanged(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}
