part of 'third_form_bloc.dart';

class ThirdFormState extends Equatable {
  const ThirdFormState({
    this.status = FormzStatus.pure,
    this.cubicCapacity = const CubicCapacityField.pure(),
    this.fuel = const FuelField.pure(),
    this.motorPower = const MotorPowerField.pure(),
    this.emission = const EmissionField.pure(),
  });

  final FormzStatus status;
  final CubicCapacityField cubicCapacity;
  final FuelField fuel;
  final MotorPowerField motorPower;
  final EmissionField emission;

  ThirdFormState copyWith({
    FormzStatus status,
    CubicCapacityField cubicCapacity,
    FuelField fuel,
    MotorPowerField motorPower,
    EmissionField emission,
  }) {
    return ThirdFormState(
      status: status ?? this.status,
      cubicCapacity: cubicCapacity ?? this.cubicCapacity,
      fuel: fuel ?? this.fuel,
      motorPower: motorPower ?? this.motorPower,
      emission: emission ?? this.emission,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [status, cubicCapacity, fuel, motorPower, emission];
}
