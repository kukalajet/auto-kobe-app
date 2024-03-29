part of 'first_form_bloc.dart';

class FirstFormState extends Equatable {
  const FirstFormState({
    this.status = FormzStatus.pure,
    this.brand = const BrandField.pure(),
    this.model = const ModelField.pure(),
    this.registration = const RegistrationField.pure(),
    this.condition = const ConditionField.pure(),
    this.price = const PriceField.pure(),
  });

  final FormzStatus status;
  final BrandField brand;
  final ModelField model;
  final RegistrationField registration;
  final ConditionField condition;
  final PriceField price;

  FirstFormState copyWith({
    FormzStatus status,
    BrandField brand,
    ModelField model,
    RegistrationField registration,
    ConditionField condition,
    PriceField price,
  }) {
    return FirstFormState(
      status: status ?? this.status,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      registration: registration ?? this.registration,
      condition: condition ?? this.condition,
      price: price ?? this.price,
    );
  }

  bool get valid => status == FormzStatus.valid;

  @override
  List<Object> get props => [
        status,
        brand,
        model,
        registration,
        price,
      ];
}
