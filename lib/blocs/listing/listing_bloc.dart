import 'dart:async';

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

  // @override
  // Stream<Transition<ListingEvent, ListingState>> transformEvents(
  //   Stream<ListingEvent> events,
  //   TransitionFunction<ListingEvent, ListingState> transitionFunction,
  // ) {
  //   return super.transformEvents(
  //       events.debounceTime(const Duration(milliseconds: 500)),
  //       transitionFunction);
  // }

  @override
  Stream<ListingState> mapEventToState(
    ListingEvent event,
  ) async* {
    if (event is ListingFetched) {
      yield await _mapListingFetchedToState(state);
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
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ListingStatus.failure);
    }
  }
}
