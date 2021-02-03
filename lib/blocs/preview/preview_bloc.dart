import 'package:auto_kobe/blocs/search/search_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_repository/listing_repository.dart';

part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  PreviewBloc({ListingRepository listingRepository})
      : assert(ListingRepository != null),
        _listingRepository = listingRepository,
        super(const PreviewState());

  final ListingRepository _listingRepository;

  @override
  Stream<PreviewState> mapEventToState(PreviewEvent event) async* {
    if (event is PreviewListingsFetched) {
      yield await _mapPreviewListingsFetchedToState(state);
    }
  }

  Future<PreviewState> _mapPreviewListingsFetchedToState(
    PreviewState state,
  ) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PreviewStatus.initial) {
        final previews = await _listingRepository.fetchPreviews(0, 20);
        return state.copyWith(
          status: PreviewStatus.success,
          previews: previews,
          hasReachedMax: false,
        );
      }

      final previews =
          await _listingRepository.fetchPreviews(state.previews.length, 20);
      return previews.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PreviewStatus.success,
              previews: List.of(state.previews)..addAll(previews),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: PreviewStatus.failure);
    }
  }
}
