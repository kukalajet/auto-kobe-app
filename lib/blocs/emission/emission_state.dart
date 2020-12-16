part of 'emission_bloc.dart';

enum EmissionStatus { initial, success, failure }

class EmissionState extends Equatable {
  const EmissionState({
    this.status = EmissionStatus.initial,
    this.emissions = const <Emission>[],
  });

  final EmissionStatus status;
  final List<Emission> emissions;

  EmissionState copyWith({
    EmissionStatus status,
    List<Emission> emissions,
  }) {
    return EmissionState(
      status: status ?? this.status,
      emissions: emissions ?? this.emissions,
    );
  }

  @override
  List<Object> get props => [status, emissions];
}
