part of 'emission_bloc.dart';

abstract class EmissionEvent extends Equatable {
  const EmissionEvent();

  @override
  List<Object> get props => [];
}

class EmissionFetched extends EmissionEvent {}
