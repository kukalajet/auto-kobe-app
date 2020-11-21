part of 'door_type_bloc.dart';

enum DoorTypeStatus { initial, success, failure }

class DoorTypeState extends Equatable {
  const DoorTypeState({
    this.status = DoorTypeStatus.initial,
    this.types = const <DoorType>[],
  });

  final DoorTypeStatus status;
  final List<DoorType> types;

  DoorTypeState copyWith({
    DoorTypeStatus status,
    List<DoorType> types,
  }) {
    return DoorTypeState(
      status: status ?? this.status,
      types: types ?? this.types,
    );
  }

  @override
  List<Object> get props => [status, types];
}
