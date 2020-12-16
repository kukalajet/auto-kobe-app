part of 'second_form_bloc.dart';

class SecondFormState extends Equatable {
  const SecondFormState({
    this.status = FormzStatus.pure,
    this.country = const OriginCountryField.pure(),
    this.doors = const DoorsField.pure(),
    this.mileage = const MileageField.pure(),
    this.transmission = const TransmissionField.pure(),
  });

  final FormzStatus status;
  final OriginCountryField country;
  final DoorsField doors;
  final MileageField mileage;
  final TransmissionField transmission;

  SecondFormState copyWith({
    FormzStatus status,
    OriginCountryField country,
    DoorsField doors,
    MileageField mileage,
    TransmissionField transmission,
  }) {
    return SecondFormState(
      status: status ?? this.status,
      country: country ?? this.country,
      doors: doors ?? this.doors,
      mileage: mileage ?? this.mileage,
      transmission: transmission ?? this.transmission,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [status, mileage, country, doors, transmission];
}
