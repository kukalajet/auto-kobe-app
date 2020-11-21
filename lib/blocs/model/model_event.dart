part of 'model_bloc.dart';

abstract class ModelEvent extends Equatable {
  const ModelEvent();

  // @override
  // List<Object> get props => [];
}

class ModelFetched extends ModelEvent {
  final Brand brand;

  const ModelFetched(this.brand);

  @override
  List<Object> get props => [brand];

  @override
  String toString() => 'ModelFetched { brand: $brand }';
}
