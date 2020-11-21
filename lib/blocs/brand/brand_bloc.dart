import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:brand_repository/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc({
    @required BrandRepository brandRepository,
  })  : assert(brandRepository != null),
        _brandRepository = brandRepository,
        super(BrandInitial());

  final BrandRepository _brandRepository;

  @override
  Stream<BrandState> mapEventToState(
    BrandEvent event,
  ) async* {
    if (event is BrandFetched) {
      yield await _mapBrandFetchedToState(state);
    } else if (event is BrandFavoriteFetched) {
      yield await _mapBrandFavoritesFetchedToState(state);
    }
  }

  Future<BrandState> _mapBrandFetchedToState(BrandState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == BrandStatus.initial) {
        final brands = await _brandRepository.fetchBrands(0, 20);
        return state.copyWith(
          status: BrandStatus.success,
          brands: brands,
          hasReachedMax: false,
        );
      }

      final brands =
          await _brandRepository.fetchBrands(state.brands.length, 20);
      return brands.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: BrandStatus.success,
              brands: List.of(state.brands)..addAll(brands),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: BrandStatus.failure);
    }
  }

  Future<BrandState> _mapBrandFavoritesFetchedToState(BrandState state) async {
    try {
      if (state.favoriteStatus == BrandFavoriteStatus.initial) {
        final favorites = await _brandRepository.fetchFavorites();
        return favorites.isEmpty
            ? state.copyWith(favoriteStatus: BrandFavoriteStatus.empty)
            : state.copyWith(favorites: favorites);
      }

      // NOTE: Should we return this? Maybe it shouldn't have an `initial` state.
      return state.copyWith();
    } on Exception {
      return state.copyWith(favoriteStatus: BrandFavoriteStatus.failure);
    }
  }
}
