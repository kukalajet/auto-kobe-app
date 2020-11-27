part of 'valute_bloc.dart';

abstract class ValuteEvent extends Equatable {
  const ValuteEvent();

  @override
  List<Object> get props => [];
}

class ValuteFetched extends ValuteEvent {}
