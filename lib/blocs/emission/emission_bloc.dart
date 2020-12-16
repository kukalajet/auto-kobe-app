import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:emission_repository/emission_repository.dart';
import 'package:meta/meta.dart';

part 'emission_event.dart';
part 'emission_state.dart';

class EmissionBloc extends Bloc<EmissionEvent, EmissionState> {
  EmissionBloc({
    @required EmissionRepository emissionRepository,
  })  : assert(emissionRepository != null),
        _emissionRepository = emissionRepository,
        super(const EmissionState());

  final EmissionRepository _emissionRepository;

  @override
  Stream<EmissionState> mapEventToState(
    EmissionEvent event,
  ) async* {
    if (event is EmissionFetched) {
      yield await _mapEmissionFetchedToState(state);
    }
  }

  Future<EmissionState> _mapEmissionFetchedToState(EmissionState state) async {
    try {
      final emissions = await _emissionRepository.fetchEmissions();
      return state.copyWith(
        status: EmissionStatus.success,
        emissions: emissions,
      );
    } on Exception {
      return state.copyWith(status: EmissionStatus.failure);
    }
  }
}
