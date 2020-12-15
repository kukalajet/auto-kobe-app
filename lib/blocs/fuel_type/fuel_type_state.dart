part of 'fuel_type_bloc.dart';

enum FuelTypeStatus { initial, success, failure }

class FuelTypeState extends Equatable {
  const FuelTypeState({
    this.status = FuelTypeStatus.initial,
    this.types = const <Fuel>[],
  });

  final FuelTypeStatus status;
  final List<Fuel> types;

  FuelTypeState copyWith({
    FuelTypeStatus status,
    List<Fuel> types,
  }) {
    return FuelTypeState(
      status: status ?? this.status,
      types: types ?? this.types,
    );
  }

  @override
  List<Object> get props => [status, types];
}
