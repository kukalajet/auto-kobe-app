import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:country_repository/country_repository.dart';

class ListingCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ListingWizardBloc>(
            create: (_) => ListingWizardBloc(),
          ),
          BlocProvider<FirstFormBloc>(
            create: (_) => FirstFormBloc(),
          ),
          BlocProvider<SecondFormBloc>(
            create: (_) => SecondFormBloc(),
          ),
          BlocProvider<ThirdFormBloc>(
            create: (_) => ThirdFormBloc(),
          ),
          BlocProvider<BrandBloc>(
            create: (_) => BrandBloc(
              brandRepository: RepositoryProvider.of<BrandRepository>(context),
            )
              ..add(BrandFetched())
              ..add(BrandFavoriteFetched()),
          ),
          BlocProvider<ModelBloc>(
            create: (_) => ModelBloc(
              modelRepository: RepositoryProvider.of<ModelRepository>(context),
            ),
          ),
          BlocProvider<CountryBloc>(
            create: (_) => CountryBloc(
              countryRepository:
                  RepositoryProvider.of<CountryRepository>(context),
            ),
          ),
          BlocProvider<DoorTypeBloc>(
            create: (context) => DoorTypeBloc(
              doorTypeRepository:
                  RepositoryProvider.of<DoorTypeRepository>(context),
            ),
          ),
          BlocProvider<FuelTypeBloc>(
            create: (context) => FuelTypeBloc(
              fuelTypeRepository:
                  RepositoryProvider.of<FuelTypeRepository>(context),
            ),
          ),
        ],
        child: BlocConsumer<ListingWizardBloc, ListingWizardState>(
          listener: (context, state) {
            if (state.firstForm.valid) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: const Text('FIRST_FORM PASSED')));
            }
            if (state.secondForm.valid) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: const Text('SECOND_FORM PASSED')));
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _TypeInput(),
                ), // NOTE: THIS CHOOSES WHAT KIND OF FORMS WE HAVE.
                ListingWizardFirstForm(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: state.firstForm.valid
                      ? ListingWizardSecondForm()
                      : SizedBox(),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: state.secondForm.valid
                      ? ListingWizardThirdForm()
                      : SizedBox(),
                ),
              ],
            );
          },
          buildWhen: (previousState, currentState) =>
              previousState != currentState,
        ),
      ),
    );
  }
}

class _TypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingWizardBloc, ListingWizardState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) {
        return TypePicker(
            onTypeSelected: (type) => context
                .bloc<ListingWizardBloc>()
                .add(ListingTypeChanged(type)));
      },
    );
  }
}
