part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class BrandFetched extends BrandEvent {}

class BrandFavoriteFetched extends BrandEvent {}