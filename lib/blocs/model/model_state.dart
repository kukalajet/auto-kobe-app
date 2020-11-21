part of 'model_bloc.dart';

enum ModelStatus { initial, success, failure, missingBrand }

class ModelState extends Equatable {
  final ModelStatus status;
  final Brand brand;
  final List<Model> models;
  final bool hasReachedMax;

  const ModelState({
    this.status = ModelStatus.initial,
    this.brand,
    this.models = const <Model>[],
    this.hasReachedMax = false,
  });

  ModelState copyWith({
    ModelStatus status,
    Brand brand,
    List<Model> models,
    bool hasReachedMax,
  }) {
    return ModelState(
      status: status ?? this.status,
      brand: brand ?? this.brand,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, models, hasReachedMax];
}

class ModelInitial extends ModelState {}
