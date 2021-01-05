part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = FormzStatus.pure,
    this.type = const TypeField.pure(),
    this.brand = const BrandField.pure(),
    this.model = const ModelField.pure(),
    this.registration = const RegistrationField.pure(),
    this.price = const PriceField.pure(),
    this.mileage = const MileageField.pure(),
    this.transmission = const TransmissionField.pure(),
    this.fuel = const FuelField.pure(),

    // TESTING
    this.searchingStatus = SearchStatus.initial,
    this.listings = const <Listing>[],
    this.hasReachedMax = false,
  });

  final FormzStatus status;
  final TypeField type;
  final BrandField brand;
  final ModelField model;
  final RegistrationField registration;
  final PriceField price;
  final MileageField mileage;
  final TransmissionField transmission;
  final FuelField fuel;

  // test
  final SearchStatus searchingStatus;
  final List<Listing> listings;
  final bool hasReachedMax;

  SearchState copyWith({
    FormzStatus status,
    TypeField type,
    BrandField brand,
    ModelField model,
    RegistrationField registration,
    PriceField price,
    MileageField mileage,
    TransmissionField transmission,
    FuelField fuel,

    // test
    SearchStatus searchingStatus,
    List<Listing> listings,
    bool hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      registration: registration ?? this.registration,
      price: price ?? this.price,
      mileage: mileage ?? this.mileage,
      transmission: transmission ?? this.transmission,
      fuel: fuel ?? this.fuel,

      // test
      searchingStatus: searchingStatus ?? this.searchingStatus,
      listings: listings ?? this.listings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        type,
        brand,
        model,
        registration,
        price,
        mileage,
        transmission,
        fuel,

        // test
        searchingStatus,
        listings,
        hasReachedMax,
      ];
}
