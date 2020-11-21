part of 'door_type_bloc.dart';

abstract class DoorTypeEvent extends Equatable {
  const DoorTypeEvent();

  @override
  List<Object> get props => [];
}

class DoorTypeFetched extends DoorTypeEvent {}
