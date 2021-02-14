part of 'third_form_bloc.dart';

class ThirdFormState extends Equatable {
  const ThirdFormState({
    this.status = FormzStatus.pure,
    this.cubicCapacity = const CubicCapacityField.pure(),
    this.fuel = const FuelField.pure(),
    this.motorPower = const MotorPowerField.pure(),
    this.emission = const EmissionField.pure(),
    // this.images = const ImagesField.pure(),
    this.images,
  });

  final FormzStatus status;
  final CubicCapacityField cubicCapacity;
  final FuelField fuel;
  final MotorPowerField motorPower;
  final EmissionField emission;
  final ImagesField images;

  ThirdFormState copyWith({
    FormzStatus status,
    CubicCapacityField cubicCapacity,
    FuelField fuel,
    MotorPowerField motorPower,
    EmissionField emission,
    ImagesField images,
  }) {
    return ThirdFormState(
      status: status ?? this.status,
      cubicCapacity: cubicCapacity ?? this.cubicCapacity,
      fuel: fuel ?? this.fuel,
      motorPower: motorPower ?? this.motorPower,
      emission: emission ?? this.emission,
      images: images ?? this.images,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [
        status,
        cubicCapacity,
        fuel,
        motorPower,
        emission,
        images,
      ];
}
