part of 'transmission_bloc.dart';

abstract class TransmissionEvent extends Equatable {
  const TransmissionEvent();

  @override
  List<Object> get props => [];
}

class TransmissionFetched extends TransmissionEvent {}
