// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
// import 'package:doors_repository/src/models/models.dart';
import 'models/models.dart';

class DoorTypeRepository {
  // final http.Client httpClient;

  // DoorTypeRepository({@required this.httpClient});

  Future<List<DoorType>> fetchTypes() async {
    List<DoorType> types = <DoorType>[
      DoorType(id: 0, number: '2'),
      DoorType(id: 1, number: '2/3'),
      DoorType(id: 2, number: '4'),
      DoorType(id: 3, number: '4/5'),
    ];

    return types;
  }
}
