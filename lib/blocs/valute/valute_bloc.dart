import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:valute_repository/valute_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'valute_event.dart';
part 'valute_state.dart';

class ValuteBloc extends Bloc<ValuteEvent, ValuteState> {
  ValuteBloc({
    @required ValuteRepository valuteRepository,
  })  : assert(valuteRepository != null),
        _valuteRepository = valuteRepository,
        super(const ValuteState());

  final ValuteRepository _valuteRepository;

  @override
  Stream<ValuteState> mapEventToState(
    ValuteEvent event,
  ) async* {
    if (event is ValuteFetched) {
      yield await _mapValuteFetchedToState(state);
    }
  }

  Future<ValuteState> _mapValuteFetchedToState(ValuteState state) async {
    try {
      final valutes = await _valuteRepository.fetchValutes();
      return state.copyWith(
        status: ValuteStatus.success,
        valutes: valutes,
      );
    } on Exception {
      return state.copyWith(status: ValuteStatus.failure);
    }
  }
}
