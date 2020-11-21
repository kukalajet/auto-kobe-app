part of 'second_form_bloc.dart';

abstract class SecondFormEvent extends Equatable {
  const SecondFormEvent();

  @override
  List<Object> get props => [];
}

class ListingCountryChanged extends SecondFormEvent {
  const ListingCountryChanged(this.country);

  final Country country;

  @override
  List<Object> get props => [country];
}

class ListingDoorsChanged extends SecondFormEvent {
  const ListingDoorsChanged(this.doors);

  final DoorType doors;

  @override
  List<Object> get props => [doors];
}

// class ListingSeatsChanged extends SecondFormEvent {
//   const ListingSeatsChanged(this.seats);

//   final int seats;

//   @override
//   List<Object> get props => [seats];
// }

class ListingMileageChanged extends SecondFormEvent {
  const ListingMileageChanged(this.mileage);

  final int mileage;

  @override
  List<Object> get props => [mileage];
}
