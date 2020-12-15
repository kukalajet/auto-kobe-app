// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
// import 'package:fuel_type_repository/src/models/models.dart';
import 'models/models.dart';

class FuelTypeRepository {
  // final http.Client httpClient;

  // FuelTypeRepository({@required this.httpClient});

  Future<List<Fuel>> fetchTypes() async {
    List<Fuel> types = <Fuel>[
      Fuel(id: 0, type: FuelType.Petrol),
      Fuel(id: 1, type: FuelType.Diesel),
      Fuel(id: 2, type: FuelType.Electric),
      Fuel(id: 3, type: FuelType.Hybrid),
      Fuel(id: 4, type: FuelType.BiFuel),
    ];

    return types;
  }
}
