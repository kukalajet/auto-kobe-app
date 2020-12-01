part of 'listing_bloc.dart';

abstract class ListingEvent extends Equatable {
  const ListingEvent();

  @override
  List<Object> get props => [];
}

class ListingFetched extends ListingEvent {}

class ListingSearchTypeFetched extends ListingEvent {}

class ListingSearchTypeChanged extends ListingEvent {
  const ListingSearchTypeChanged(this.type);

  final SearchType type;

  @override
  List<Object> get props => [type];
}
