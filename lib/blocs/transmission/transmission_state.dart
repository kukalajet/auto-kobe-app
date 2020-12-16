part of 'transmission_bloc.dart';

enum TransmissionStatus { initial, success, failure }

class TransmissionState extends Equatable {
  const TransmissionState({
    this.status = TransmissionStatus.initial,
    this.transmissions = const <Transmission>[],
  });

  final TransmissionStatus status;
  final List<Transmission> transmissions;

  TransmissionState copyWith({
    TransmissionStatus status,
    List<Transmission> transmissions,
  }) {
    return TransmissionState(
      status: status ?? this.status,
      transmissions: transmissions ?? this.transmissions,
    );
  }

  @override
  List<Object> get props => [status, transmissions];
}
