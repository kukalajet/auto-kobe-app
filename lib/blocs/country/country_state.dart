part of 'country_bloc.dart';

enum CountryStatus { initial, success, failure }

class CountryState extends Equatable {
  const CountryState({
    this.status = CountryStatus.initial,
    this.countries = const <Country>[],
  });

  final CountryStatus status;
  final List<Country> countries;

  CountryState copyWith({
    CountryStatus status,
    List<Country> countries,
  }) {
    return CountryState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
    );
  }

  @override
  List<Object> get props => [status, countries];
}
