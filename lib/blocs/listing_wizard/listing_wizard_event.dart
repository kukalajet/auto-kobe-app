part of 'listing_wizard_bloc.dart';

abstract class ListingWizardEvent extends Equatable {
  const ListingWizardEvent();

  @override
  List<Object> get props => [];
}

class ListingTypeChanged extends ListingWizardEvent {
  final Type type;

  const ListingTypeChanged(this.type);

  @override
  List<Object> get props => [type];
}

class FirstFormStateChanged extends ListingWizardEvent {
  final FirstFormState state;

  const FirstFormStateChanged(this.state);

  @override
  List<Object> get props => [state];
}

class SecondFormStateChanged extends ListingWizardEvent {
  final SecondFormState state;

  const SecondFormStateChanged(this.state);

  @override
  List<Object> get props => [state];
}

class ThirdFormStateChanged extends ListingWizardEvent {
  final ThirdFormState state;

  const ThirdFormStateChanged(this.state);

  @override
  List<Object> get props => [state];
}

class ListingFormSubmitted extends ListingWizardEvent {
  const ListingFormSubmitted();
}
