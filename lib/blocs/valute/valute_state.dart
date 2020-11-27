part of 'valute_bloc.dart';

enum ValuteStatus { initial, success, failure }

class ValuteState extends Equatable {
  const ValuteState({
    this.status = ValuteStatus.initial,
    this.valutes = const <Valute>[],
  });

  final ValuteStatus status;
  final List<Valute> valutes;

  ValuteState copyWith({
    ValuteStatus status,
    List<Valute> valutes,
  }) {
    return ValuteState(
      status: status ?? this.status,
      valutes: valutes ?? this.valutes,
    );
  }

  @override
  List<Object> get props => [status, valutes];
}
