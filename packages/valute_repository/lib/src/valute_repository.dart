import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class ValuteRepository {
  ValuteRepository({@required this.httpClient});

  final http.Client httpClient;

  Future<List<Valute>> fetchValutes() async {
    List<Valute> valutes = <Valute>[
      Valute(id: 0, name: 'Lekë', symbol: 'L'),
      Valute(id: 1, name: 'Euro', symbol: '€'),
      Valute(id: 2, name: 'Dollar', symbol: '\$'),
      Valute(id: 3, name: 'Pound', symbol: '£'),
    ];

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => valutes,
    );
  }
}
