part of 'condition_bloc.dart';

abstract class ConditionEvent extends Equatable {
  const ConditionEvent();

  @override
  List<Object> get props => [];
}

class ConditionFetched extends ConditionEvent {}
