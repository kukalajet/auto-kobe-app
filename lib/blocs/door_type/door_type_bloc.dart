import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:meta/meta.dart';

part 'door_type_event.dart';
part 'door_type_state.dart';

class DoorTypeBloc extends Bloc<DoorTypeEvent, DoorTypeState> {
  DoorTypeBloc({
    @required DoorTypeRepository doorTypeRepository,
  })  : assert(doorTypeRepository != null),
        _doorTypeRepository = doorTypeRepository,
        super(const DoorTypeState());

  final DoorTypeRepository _doorTypeRepository;

  @override
  Stream<DoorTypeState> mapEventToState(
    DoorTypeEvent event,
  ) async* {
    if (event is DoorTypeFetched) {
      yield await _mapTypeFetchedToState(state);
    }
  }

  Future<DoorTypeState> _mapTypeFetchedToState(DoorTypeState state) async {
    try {
      final types = await _doorTypeRepository.fetchTypes();
      return state.copyWith(
        status: DoorTypeStatus.success,
        types: types,
      );
    } on Exception {
      return state.copyWith(status: DoorTypeStatus.failure);
    }
  }
}
