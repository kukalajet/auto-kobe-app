part of 'fuel_type_bloc.dart';

abstract class FuelTypeEvent extends Equatable {
  const FuelTypeEvent();

  @override
  List<Object> get props => [];
}

class FuelTypeFetched extends FuelTypeEvent {}
