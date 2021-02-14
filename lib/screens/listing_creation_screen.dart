import 'package:auto_kobe/styles/text/text_style.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:model_repository/model_repository.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:condition_repository/condition_repository.dart';

class ListingCreationScreen extends StatelessWidget {
  Widget _buildCreationButton(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: ButtonTheme(
        minWidth: width,
        height: 56.0,
        child: RaisedButton(
          onPressed: () => {},
          child: Text(
            "CREATE",
            style: textBodyStyleLight,
          ),
          color: ColorConstant.primaryVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
            side: BorderSide(color: ColorConstant.primaryVariant),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        BlocProvider<ConditionBloc>(
          create: (context) => ConditionBloc(
            conditionRepository:
                RepositoryProvider.of<ConditionRepository>(context),
          ),
        ),
      ],
      child: Material(
        child: CupertinoScaffold(
          transitionBackgroundColor: kWhite,
          body: BlocConsumer<ListingWizardBloc, ListingWizardState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TypeInput(),
                    ),
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
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: state.thirdForm.valid
                          ? _buildCreationButton(context)
                          : SizedBox(),
                    ),
                    SizedBox(height: 32.0),
                  ],
                ),
              );
            },
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
          ),
        ),
      ),
    );
  }
}
