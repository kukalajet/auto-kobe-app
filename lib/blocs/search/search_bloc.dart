import 'package:auto_kobe/models/type.dart';
import 'package:bloc/bloc.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:auto_kobe/models/search/search.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:meta/meta.dart';
import 'package:model_repository/model_repository.dart';
import 'package:transmission_repository/transmission_repository.dart';
import 'package:valute_repository/valute_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    @required ListingRepository listingRepository,
  })  : assert(listingRepository != null),
        _listingRepository = listingRepository,
        super(const SearchState());

  final ListingRepository _listingRepository;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTypeChanged) {
      yield _mapTypeChangedToState(event, state);
    } else if (event is SearchBrandChanged) {
      yield _mapBrandChangedToState(event, state);
    } else if (event is SearchFuelChanged) {
      yield _mapFuelChangedToState(event, state);
    } else if (event is SearchMileageChanged) {
      yield _mapMileageChangedToState(event, state);
    } else if (event is SearchModelChanged) {
      yield _mapModelChangedToState(event, state);
    } else if (event is SearchPriceChanged) {
      yield _mapPriceChangedToState(event, state);
    } else if (event is SearchRegistrationChanged) {
      yield _mapRegistrationChangedToState(event, state);
    } else if (event is SearchTransmissionChanged) {
      yield _mapTransmissionChangedToState(event, state);
    } else if (event is SearchedListingFetched) {
      yield await _mapSearchedListingFetchedToState(state);
    }
  }

  SearchState _mapTypeChangedToState(
    SearchTypeChanged event,
    SearchState state,
  ) {
    final type = TypeField.dirty(event.type);
    return state.copyWith(
      type: type,
      status: Formz.validate([
        type,
        state.brand,
        state.fuel,
        state.mileage,
        state.model,
        state.price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapBrandChangedToState(
    SearchBrandChanged event,
    SearchState state,
  ) {
    final brand = BrandField.dirty(event.brand);
    return state.copyWith(
      brand: brand,
      status: Formz.validate([
        state.type,
        brand,
        state.fuel,
        state.mileage,
        state.model,
        state.price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapFuelChangedToState(
    SearchFuelChanged event,
    SearchState state,
  ) {
    final fuel = FuelField.dirty(event.fuel);
    return state.copyWith(
      fuel: fuel,
      status: Formz.validate([
        state.type,
        state.brand,
        fuel,
        state.mileage,
        state.model,
        state.price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapMileageChangedToState(
    SearchMileageChanged event,
    SearchState state,
  ) {
    final values = [event.lowerLimit, event.upperLimit];
    final mileage = MileageField.dirty(values);
    return state.copyWith(
      mileage: mileage,
      status: Formz.validate([
        state.type,
        state.brand,
        state.fuel,
        mileage,
        state.model,
        state.price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapModelChangedToState(
    SearchModelChanged event,
    SearchState state,
  ) {
    final model = ModelField.dirty(event.model);
    return state.copyWith(
      model: model,
      status: Formz.validate([
        state.type,
        state.brand,
        state.fuel,
        state.mileage,
        model,
        state.price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapPriceChangedToState(
    SearchPriceChanged event,
    SearchState state,
  ) {
    final values = [event.lowerLimit, event.upperLimit];
    final price = PriceField.dirty(values);
    return state.copyWith(
      price: price,
      status: Formz.validate([
        state.type,
        state.brand,
        state.fuel,
        state.mileage,
        state.model,
        price,
        state.registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapRegistrationChangedToState(
    SearchRegistrationChanged event,
    SearchState state,
  ) {
    final values = [event.lowerLimit, event.upperLimit];
    final registration = RegistrationField.dirty(values);
    return state.copyWith(
      registration: registration,
      status: Formz.validate([
        state.type,
        state.brand,
        state.fuel,
        state.mileage,
        state.model,
        state.price,
        registration,
        state.transmission,
      ]),
    );
  }

  SearchState _mapTransmissionChangedToState(
    SearchTransmissionChanged event,
    SearchState state,
  ) {
    final transmission = TransmissionField.dirty(event.transmission);
    return state.copyWith(
      transmission: transmission,
      status: Formz.validate([
        state.type,
        state.brand,
        state.fuel,
        state.mileage,
        state.model,
        state.price,
        state.registration,
        transmission,
      ]),
    );
  }

  Future<SearchState> _mapSearchedListingFetchedToState(
    SearchState state,
  ) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.searchingStatus == SearchStatus.initial) {
        final listings = await _listingRepository.fetchListings(0, 20);
        return state.copyWith(
          searchingStatus: SearchStatus.success,
          listings: listings,
          hasReachedMax: false,
          status: Formz.validate([
            state.type,
            state.brand,
            state.fuel,
            state.mileage,
            state.model,
            state.price,
            state.registration,
            state.transmission,
          ]),
        );
      }

      final listings =
          await _listingRepository.fetchListings(state.listings.length, 20);
      return listings.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              searchingStatus: SearchStatus.success,
              listings: List.of(state.listings)..addAll(listings),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(searchingStatus: SearchStatus.failure);
    }
  }
}
