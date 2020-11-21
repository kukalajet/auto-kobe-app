// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
// import 'package:fuel_type_repository/src/models/models.dart';
import 'models/models.dart';

class FuelTypeRepository {
  // final http.Client httpClient;

  // FuelTypeRepository({@required this.httpClient});

  Future<List<FuelType>> fetchTypes() async {
    List<FuelType> types = <FuelType>[
      FuelType(id: 0, type: 'Petrol'),
      FuelType(id: 1, type: 'Diesel'),
      FuelType(id: 2, type: 'Electric'),
      FuelType(id: 3, type: 'Hybrids'),
      FuelType(id: 4, type: 'Bi fuel'),
    ];

    return types;
  }
}
