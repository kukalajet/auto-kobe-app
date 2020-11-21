part of 'brand_bloc.dart';

enum BrandStatus { initial, success, failure }
enum BrandFavoriteStatus { initial, success, failure, empty }

class BrandState extends Equatable {
  final BrandStatus status;
  final BrandFavoriteStatus favoriteStatus;
  final List<Brand> brands;
  final List<Brand> favorites;
  final bool hasReachedMax;

  const BrandState({
    this.status = BrandStatus.initial,
    this.favoriteStatus = BrandFavoriteStatus.initial,
    this.brands = const <Brand>[],
    this.favorites = const <Brand>[],
    this.hasReachedMax = false,
  });

  BrandState copyWith({
    BrandStatus status,
    BrandFavoriteStatus favoriteStatus,
    List<Brand> brands,
    List<Brand> favorites,
    bool hasReachedMax,
  }) {
    return BrandState(
      status: status ?? this.status,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
      brands: brands ?? this.brands,
      favorites: favorites ?? this.favorites,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [status, favoriteStatus, brands, favorites, hasReachedMax];
}

class BrandInitial extends BrandState {}
