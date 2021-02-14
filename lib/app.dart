import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_kobe/blocs/brand/brand_bloc.dart';
import 'package:auto_kobe/blocs/door_type/door_type.dart';
import 'package:country_repository/country_repository.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:auto_kobe/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/screens/screens.dart';
import 'package:model_repository/model_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:valute_repository/valute_repository.dart';
import 'package:condition_repository/condition_repository.dart';
import 'package:transmission_repository/transmission_repository.dart';
import 'package:emission_repository/emission_repository.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.listingRepository,
    @required this.brandRepository,
    @required this.modelRepository,
    @required this.countryRepository,
    @required this.doorTypeRepository,
    @required this.fuelTypeRepository,
    @required this.valuteRepository,
    @required this.conditionRepository,
    @required this.transmissionRepository,
    @required this.emissionRepository,
  })  : assert(authenticationRepository != null),
        assert(listingRepository != null),
        assert(brandRepository != null),
        assert(modelRepository != null),
        assert(countryRepository != null),
        assert(doorTypeRepository != null),
        assert(fuelTypeRepository != null),
        assert(valuteRepository != null),
        assert(conditionRepository != null),
        assert(transmissionRepository != null),
        assert(emissionRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final ListingRepository listingRepository;
  final BrandRepository brandRepository;
  final ModelRepository modelRepository;
  final CountryRepository countryRepository;
  final DoorTypeRepository doorTypeRepository;
  final FuelTypeRepository fuelTypeRepository;
  final ValuteRepository valuteRepository;
  final ConditionRepository conditionRepository;
  final TransmissionRepository transmissionRepository;
  final EmissionRepository emissionRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      //? Are all these providers needed?
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => authenticationRepository,
        ),
        RepositoryProvider<ListingRepository>(
          create: (_) => listingRepository,
        ),
        RepositoryProvider<BrandRepository>(
          create: (_) => brandRepository,
        ),
        RepositoryProvider<ModelRepository>(
          create: (_) => modelRepository,
        ),
        RepositoryProvider<CountryRepository>(
          create: (_) => countryRepository,
        ),
        RepositoryProvider<DoorTypeRepository>(
          create: (_) => doorTypeRepository,
        ),
        RepositoryProvider<FuelTypeRepository>(
          create: (_) => fuelTypeRepository,
        ),
        RepositoryProvider<ValuteRepository>(
          create: (_) => valuteRepository,
        ),
        RepositoryProvider<ConditionRepository>(
          create: (_) => conditionRepository,
        ),
        RepositoryProvider<TransmissionRepository>(
          create: (_) => transmissionRepository,
        ),
        RepositoryProvider<EmissionRepository>(
          create: (_) => emissionRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<TabBloc>(
            create: (_) => TabBloc(),
          ),
          BlocProvider<BrandBloc>(
            create: (_) => BrandBloc(brandRepository: brandRepository),
          ),
          BlocProvider<ModelBloc>(
            create: (_) => ModelBloc(modelRepository: modelRepository),
          ),
          BlocProvider<CountryBloc>(
            create: (_) => CountryBloc(countryRepository: countryRepository),
          ),
          BlocProvider<DoorTypeBloc>(
            create: (_) => DoorTypeBloc(doorTypeRepository: doorTypeRepository),
          ),
          BlocProvider<FuelTypeBloc>(
            create: (_) => FuelTypeBloc(fuelTypeRepository: fuelTypeRepository),
          ),
          BlocProvider<ValuteBloc>(
            create: (_) => ValuteBloc(valuteRepository: valuteRepository),
          ),
          BlocProvider<ConditionBloc>(
            create: (_) =>
                ConditionBloc(conditionRepository: conditionRepository),
          ),
          BlocProvider<TransmissionBloc>(
            create: (_) => TransmissionBloc(
                transmissionRepository: transmissionRepository),
          ),
          BlocProvider<EmissionBloc>(
            create: (_) => EmissionBloc(emissionRepository: emissionRepository),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              // case AuthenticationStatus.authenticated:
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              // case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  OnboardingScreen.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
