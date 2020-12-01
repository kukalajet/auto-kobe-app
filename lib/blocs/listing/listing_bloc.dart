import 'dart:async';

import 'package:auto_kobe/models/models.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc({
    @required ListingRepository listingRepository,
  })  : assert(listingRepository != null),
        _listingRepository = listingRepository,
        super(const ListingState());

  final ListingRepository _listingRepository;

  @override
  Stream<ListingState> mapEventToState(
    ListingEvent event,
  ) async* {
    if (event is ListingFetched) {
      yield await _mapListingFetchedToState(state);
    } else if (event is ListingSearchTypeFetched) {
      yield await _mapListingSearchTypeFetchedToState(state);
    } else if (event is ListingSearchTypeChanged) {
      yield _mapListingSearchtypeChangedToState(event, state);
    }
  }

  Future<ListingState> _mapListingFetchedToState(ListingState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == ListingStatus.initial) {
        final listings = await _listingRepository.fetchListings(0, 20);
        return state.copyWith(
          status: ListingStatus.success,
          listings: listings,
          types: state.types,
          selectedType: state.selectedType,
          hasReachedMax: false,
        );
      }

      final listings =
          await _listingRepository.fetchListings(state.listings.length, 20);
      return listings.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ListingStatus.success,
              listings: List.of(state.listings)..addAll(listings),
              types: state.types,
              selectedType: state.selectedType,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ListingStatus.failure);
    }
  }

  Future<ListingState> _mapListingSearchTypeFetchedToState(
      ListingState state) async {
    final types = await _listingRepository.fetchSearchTypes();
    return state.copyWith(
      status: state.status,
      listings: state.listings,
      types: types,
      selectedType: state.selectedType,
      hasReachedMax: state.hasReachedMax,
    );
  }

  ListingState _mapListingSearchtypeChangedToState(
    ListingSearchTypeChanged event,
    ListingState state,
  ) {
    final selectedType = SelectedTypeField.dirty(event.type);
    return state.copyWith(
      status: state.status,
      listings: state.listings,
      types: state.types,
      selectedType: selectedType,
      hasReachedMax: state.hasReachedMax,
    );
  }
}
