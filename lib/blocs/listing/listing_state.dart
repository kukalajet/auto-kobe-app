part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

class ListingState extends Equatable {
  const ListingState({
    this.status = ListingStatus.initial,
    this.listings = const <Listing>[],
    this.hasReachedMax = false,
  });

  final ListingStatus status;
  final List<Listing> listings;
  final bool hasReachedMax;

  ListingState copyWith({
    ListingStatus status,
    List<Listing> listings,
    bool hasReachedMax,
  }) {
    return ListingState(
      status: status ?? this.status,
      listings: listings ?? this.listings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, listings, hasReachedMax];
}
