part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTypeChanged extends SearchEvent {
  const SearchTypeChanged(this.type);

  final Type type;

  @override
  List<Object> get props => [type];
}

class SearchBrandChanged extends SearchEvent {
  const SearchBrandChanged(this.brand);

  final Brand brand;

  @override
  List<Object> get props => [brand];
}

class SearchModelChanged extends SearchEvent {
  const SearchModelChanged(this.model);

  final Model model;

  @override
  List<Object> get props => [model];
}

class SearchFuelChanged extends SearchEvent {
  const SearchFuelChanged(this.fuel);

  final Fuel fuel;

  @override
  List<Object> get props => [fuel];
}

class SearchMileageChanged extends SearchEvent {
  const SearchMileageChanged(
    this.lowerLimit,
    this.upperLimit,
  );

  final double lowerLimit;
  final double upperLimit;

  @override
  List<Object> get props => [lowerLimit, upperLimit];
}

class SearchPriceChanged extends SearchEvent {
  const SearchPriceChanged(
    this.lowerLimit,
    this.upperLimit,
  );

  final Price lowerLimit;
  final Price upperLimit;

  @override
  List<Object> get props => [lowerLimit, upperLimit];
}

class SearchRegistrationChanged extends SearchEvent {
  const SearchRegistrationChanged(
    this.lowerLimit,
    this.upperLimit,
  );

  final Date lowerLimit;
  final Date upperLimit;

  @override
  List<Object> get props => [lowerLimit, upperLimit];
}

class SearchTransmissionChanged extends SearchEvent {
  const SearchTransmissionChanged(this.transmission);

  final Transmission transmission;

  @override
  List<Object> get props => [transmission];
}
