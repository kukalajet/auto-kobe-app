import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:condition_repository/condition_repository.dart';
import 'package:meta/meta.dart';

part 'condition_event.dart';
part 'condition_state.dart';

class ConditionBloc extends Bloc<ConditionEvent, ConditionState> {
  ConditionBloc({
    @required ConditionRepository conditionRepository,
  })  : assert(conditionRepository != null),
        _fuelTypeRepository = conditionRepository,
        super(const ConditionState());

  final ConditionRepository _fuelTypeRepository;

  @override
  Stream<ConditionState> mapEventToState(
    ConditionEvent event,
  ) async* {
    if (event is ConditionFetched) {
      yield await _mapConditionFetchedToState(state);
    }
  }

  Future<ConditionState> _mapConditionFetchedToState(
      ConditionState state) async {
    try {
      final conditions = await _fuelTypeRepository.fetchConditions();
      return state.copyWith(
        status: ConditionStatus.success,
        conditions: conditions,
      );
    } on Exception {
      return state.copyWith(status: ConditionStatus.failure);
    }
  }
}
