part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

class ListingState extends Equatable {
  const ListingState({
    this.status = ListingStatus.initial,
    this.listings = const <Listing>[],
    this.types = const <SearchType>[],
    this.selectedType =
        const SelectedTypeField.dirty(SearchType(id: 0, title: 'Latest')),
    this.hasReachedMax = false,
  });

  final ListingStatus status;
  final List<Listing> listings;
  final List<SearchType> types;
  final SelectedTypeField selectedType;
  final bool hasReachedMax;

  ListingState copyWith({
    ListingStatus status,
    List<Listing> listings,
    List<SearchType> types,
    SelectedTypeField selectedType,
    bool hasReachedMax,
  }) {
    return ListingState(
      status: status ?? this.status,
      listings: listings ?? this.listings,
      types: types ?? this.types,
      selectedType: selectedType ?? this.selectedType,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [status, listings, types, selectedType, hasReachedMax];
}
