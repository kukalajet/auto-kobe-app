import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:valute_repository/valute_repository.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) => null,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _TypeInput(),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            _BrandInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _ModelInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _PriceInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _MileageInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _RegistrationInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _FuelInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _TransmissionInput(),
          ],
        ),
      ),
    );
  }
}

class _TypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) {
        return TypePicker(
            onTypeSelected: (type) =>
                context.bloc<SearchBloc>().add(SearchTypeChanged(type)));
      },
    );
  }
}

class _BrandInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.brand != current.brand,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.car_repair,
          hint: 'BRAND',
          value: state.brand.value.name,
          expand: true,
          picker: ListingBrandsList(
            onTap: (brand) {
              context.bloc<SearchBloc>().add(SearchBrandChanged(brand));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _ModelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.model != current.model,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.car_rental,
          hint: 'MODEL',
          value: state.model.value.name,
          picker: ListingModelsList(
            brand: state.brand.value,
            onTap: (model) {
              context.bloc<SearchBloc>().add(SearchModelChanged(model));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _FuelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.fuel != current.fuel,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.access_time,
          hint: 'FUEL TYPE',
          value: state.fuel.value.type != null
              ? state.fuel.value.type.toString().split('.').last
              : null,
          picker: ListingFuelTypesList(
            onTap: (type) {
              context.bloc<SearchBloc>().add(SearchFuelChanged(type));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _TransmissionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          previous.transmission != current.transmission,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.add_link,
          hint: 'TRANSMISSION',
          value: state.transmission.value.type != null
              ? state.transmission.value.type.toString().split('.').last
              : null,
          picker: ListingTrasmissionsList(
            onTap: (transmission) {
              context
                  .bloc<SearchBloc>()
                  .add(SearchTransmissionChanged(transmission));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _MileageInput extends StatelessWidget {
  String _getValue(SearchState state) {
    if (state.mileage.value.isEmpty) return null;
    final lower = state.mileage.value[0];
    final upper = state.mileage.value[1];
    if (lower == 0) return 'UP TO ${upper.toInt()} KM';
    if (upper == 500000) return 'FROM ${lower.toInt()} KM';
    return 'FROM ${lower.toInt()} KM TO ${upper.toInt()} KM';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.mileage != current.mileage,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.timelapse,
          hint: 'MILEAGE',
          value: _getValue(state),
          expand: false,
          picker: MileageSearchSlider(context: context),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  double _maxValue(Valute valute) {
    if (valute.id == Valute.leke().id) return 50000000;
    return 50000;
  }

  String _getValue(SearchState state) {
    if (state.price.value.isEmpty) return null;
    final lower = state.price.value[0].value;
    final upper = state.price.value[1].value;
    final valute = state.price.value[0].valute;
    if (lower == 0.0 && upper >= _maxValue(valute)) return null;
    if (lower == 0.0) return 'UP TO ${upper.toInt()}${valute.symbol}';
    if (upper == _maxValue(valute))
      return 'FROM ${lower.toInt()}${valute.symbol}';
    return 'FROM ${lower.toInt()}${valute.symbol} TO ${upper.toInt()}${valute.symbol}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        final state = context.watch<SearchBloc>().state;
        if (state.price.value.isEmpty) {
          Price lowerLimit = Price(value: 0.0, valute: Valute.euro());
          Price upperLimit =
              Price(value: double.infinity, valute: Valute.euro());

          context
              .watch<SearchBloc>()
              .add(SearchPriceChanged(lowerLimit, upperLimit));
        }

        return PickerInputField(
          icon: Icons.money,
          hint: 'PRICE',
          // value: null,
          value: _getValue(state),
          expand: false,
          picker: PriceSearchSlider(context: context),
        );
      },
    );
  }
}

class _RegistrationInput extends StatelessWidget {
  String _getValue(SearchState state) {
    if (state.registration.value.isEmpty) return null;
    final lower = state.registration.value[0].year;
    final upper = state.registration.value[1].year;
    if (lower == Date.lowerValue().year) return 'UP TO $upper';
    if (upper == Date.upperValue().year) return 'FROM $lower';
    return 'FROM $lower to $upper';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          previous.registration != current.registration,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.timelapse,
          hint: 'REGISTRATION YEAR',
          value: _getValue(state),
          expand: false,
          picker: RegistrationSearchSlider(context: context),
        );
      },
    );
  }
}
