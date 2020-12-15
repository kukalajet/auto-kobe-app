part of 'condition_bloc.dart';

enum ConditionStatus { initial, success, failure }

class ConditionState extends Equatable {
  const ConditionState({
    this.status = ConditionStatus.initial,
    this.conditions = const <Condition>[],
  });

  final ConditionStatus status;
  final List<Condition> conditions;

  ConditionState copyWith({
    ConditionStatus status,
    List<Condition> conditions,
  }) {
    return ConditionState(
      status: status ?? this.status,
      conditions: conditions ?? this.conditions,
    );
  }

  @override
  List<Object> get props => [status, conditions];
}
