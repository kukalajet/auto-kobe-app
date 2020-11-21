import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:model_repository/model_repository.dart';
import 'package:brand_repository/brand_repository.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  final ModelRepository _modelRepository;

  ModelBloc({
    @required ModelRepository modelRepository,
  })  : assert(modelRepository != null),
        _modelRepository = modelRepository,
        super(ModelInitial());

  @override
  Stream<ModelState> mapEventToState(
    ModelEvent event,
  ) async* {
    if (event is ModelFetched) {
      yield await _mapModelFetchedToState(
        state,
        event.brand,
      );
    }
  }

  Future<ModelState> _mapModelFetchedToState(
    ModelState state,
    Brand brand,
  ) async {
    if (state.hasReachedMax) return state;

    // Brand brand = state.brand ??= event.brand;
    // if (state.brand == null) {
    if (brand == null) {
      return state.copyWith(status: ModelStatus.missingBrand);
    }
    try {
      if (state.status == ModelStatus.initial) {
        // TODO: Should we check if there is a brand id?
        // ignore: todo
        // TODO: Implement impagination (?)
        // final models = await _modelRepository.fetchModels(state.brand.id);
        final models = await _modelRepository.fetchModels(brand.id);
        return models.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: ModelStatus.success,
                models: List.of(state.models)..addAll(models),
                hasReachedMax: false,
              );
      }

      // final models = await _modelRepository.fetchModels(state.brand.id);
      final models = await _modelRepository.fetchModels(brand.id);
      return models.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ModelStatus.success,
              models: List.of(state.models)..addAll(models),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ModelStatus.failure);
    }
  }
}
