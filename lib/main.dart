import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:auto_kobe/app.dart';
import 'package:auto_kobe/blocs/simple_bloc_observer.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:valute_repository/valute_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  final client = http.Client();
  final storage = new FlutterSecureStorage();
  runApp(
    App(
      authenticationRepository:
          AuthenticationRepository(httpClient: client, storage: storage),
      listingRepository: ListingRepository(httpClient: client),
      brandRepository: BrandRepository(httpClient: client),
      modelRepository: ModelRepository(httpClient: client),
      countryRepository: CountryRepository(),
      doorTypeRepository: DoorTypeRepository(),
      fuelTypeRepository: FuelTypeRepository(),
      valuteRepository: ValuteRepository(httpClient: client),
    ),
  );
}
