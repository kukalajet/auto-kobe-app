part of 'first_form_bloc.dart';

class FirstFormState extends Equatable {
  const FirstFormState({
    this.status = FormzStatus.pure,
    this.brand = const BrandField.pure(),
    this.model = const ModelField.pure(),
    this.registration = const RegistrationField.pure(),
    this.price = const PriceField.pure(),
  });

  final FormzStatus status;
  final BrandField brand;
  final ModelField model;
  final RegistrationField registration;
  final PriceField price;

  FirstFormState copyWith({
    FormzStatus status,
    BrandField brand,
    ModelField model,
    RegistrationField registration,
    PriceField price,
  }) {
    return FirstFormState(
      status: status ?? this.status,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      registration: registration ?? this.registration,
      price: price ?? this.price,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [status, brand, model, registration, price];
}
