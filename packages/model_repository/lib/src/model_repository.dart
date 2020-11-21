import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:model_repository/src/models/models.dart';

import 'models/model.dart';

class ModelRepository {
  final http.Client httpClient;

  ModelRepository({@required this.httpClient});

  Future<List<Model>> fetchModels(int brandId) async {
    List<Model> models = <Model>[
      Model(id: 0, name: 'Honda Motor Company'),
      Model(id: 1, name: 'Fiat Chrysler Automobiles'),
      Model(id: 2, name: 'Volkswagen Group'),
      Model(id: 3, name: 'BMW Group'),
      Model(id: 4, name: 'Volkswagen Group'),
      Model(id: 5, name: 'General Motors'),
      Model(id: 6, name: 'Ford Motor Co.'),
      Model(id: 7, name: 'Hyundai Motor Group'),
      Model(id: 8, name: 'Renault-Nissan-Mitsubishi Alliance'),
      Model(id: 9, name: 'Tata Motors'),
      Model(id: 10, name: 'Toyota Motor Corp.'),
    ];
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => models,
    );
  }
}
