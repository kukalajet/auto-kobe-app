import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:meta/meta.dart';

part 'fuel_type_event.dart';
part 'fuel_type_state.dart';

class FuelTypeBloc extends Bloc<FuelTypeEvent, FuelTypeState> {
  FuelTypeBloc({
    @required FuelTypeRepository fuelTypeRepository,
  })  : assert(fuelTypeRepository != null),
        _fuelTypeRepository = fuelTypeRepository,
        super(const FuelTypeState());

  final FuelTypeRepository _fuelTypeRepository;

  @override
  Stream<FuelTypeState> mapEventToState(
    FuelTypeEvent event,
  ) async* {
    if (event is FuelTypeFetched) {
      yield await _mapTypeFetchedToState(state);
    }
  }

  Future<FuelTypeState> _mapTypeFetchedToState(FuelTypeState state) async {
    try {
      final types = await _fuelTypeRepository.fetchTypes();
      return state.copyWith(
        status: FuelTypeStatus.success,
        types: types,
      );
    } on Exception {
      return state.copyWith(status: FuelTypeStatus.failure);
    }
  }
}
