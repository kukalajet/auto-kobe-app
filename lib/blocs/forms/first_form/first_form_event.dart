part of 'first_form_bloc.dart';

abstract class FirstFormEvent extends Equatable {
  const FirstFormEvent();

  @override
  List<Object> get props => [];
}

class ListingBrandChanged extends FirstFormEvent {
  const ListingBrandChanged(this.brand);

  final Brand brand;

  @override
  List<Object> get props => [brand];
}

class ListingModelChanged extends FirstFormEvent {
  const ListingModelChanged(this.model);

  final Model model;

  @override
  List<Object> get props => [model];
}

class ListingRegistrationChanged extends FirstFormEvent {
  const ListingRegistrationChanged(this.registration);

  final Date registration;

  @override
  List<Object> get props => [registration];
}

class ListingPriceChanged extends FirstFormEvent {
  const ListingPriceChanged(this.price);

  final int price;

  @override
  List<Object> get props => [price];
}

class ListingValuteChanged extends FirstFormEvent {
  const ListingValuteChanged(this.valute);

  final Valute valute;

  @override
  List<Object> get props => [valute];
}
