import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc({
    @required CountryRepository countryRepository,
  })  : assert(countryRepository != null),
        _countryRepository = countryRepository,
        super(const CountryState());

  final CountryRepository _countryRepository;

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is CountryFetched) {
      yield await _mapCountryFetchedToState(state);
    }
  }

  Future<CountryState> _mapCountryFetchedToState(CountryState state) async {
    try {
      final countries = await _countryRepository.fetchCountries();
      return state.copyWith(
        status: CountryStatus.success,
        countries: countries,
      );
    } on Exception {
      return state.copyWith(status: CountryStatus.failure);
    }
  }
}
