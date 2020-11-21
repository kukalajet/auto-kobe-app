part of 'listing_wizard_bloc.dart';

class ListingWizardState extends Equatable {
  const ListingWizardState({
    this.status = FormzStatus.pure,
    this.type = const TypeField.pure(),
    this.firstForm = const FirstFormInput.pure(),
    this.secondForm = const SecondFormInput.pure(),
  });

  final FormzStatus status;
  final TypeField type;
  final FirstFormInput firstForm;
  final SecondFormInput secondForm;

  ListingWizardState copyWith({
    FormzStatus status,
    TypeField type,
    FirstFormInput firstForm,
    SecondFormInput secondForm,
  }) {
    return ListingWizardState(
      status: status ?? this.status,
      type: type ?? this.type,
      firstForm: firstForm ?? this.firstForm,
      secondForm: secondForm ?? this.secondForm,
    );
  }

  @override
  List<Object> get props => [status, type, firstForm, secondForm];
}

class ListingWizardInitial extends ListingWizardState {}
