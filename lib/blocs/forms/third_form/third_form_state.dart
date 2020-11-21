part of 'third_form_bloc.dart';

class ThirdFormState extends Equatable {
  const ThirdFormState({
    this.status = FormzStatus.pure,
    this.cubicCapacity = const CubicCapacityField.pure(),
    this.fuel = const FuelField.pure(),
    this.motorPower = const MotorPowerField.pure(),
  });

  final FormzStatus status;
  final CubicCapacityField cubicCapacity;
  final FuelField fuel;
  final MotorPowerField motorPower;

  ThirdFormState copyWith({
    FormzStatus status,
    CubicCapacityField cubicCapacity,
    FuelField fuel,
    MotorPowerField motorPower,
  }) {
    return ThirdFormState(
      status: status ?? this.status,
      cubicCapacity: cubicCapacity ?? this.cubicCapacity,
      fuel: fuel ?? this.fuel,
      motorPower: motorPower ?? this.motorPower,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [status, cubicCapacity, fuel, motorPower];
}
