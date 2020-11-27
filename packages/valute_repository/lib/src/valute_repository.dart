import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class ValuteRepository {
  ValuteRepository({@required this.httpClient});

  final http.Client httpClient;

  Future<List<Valute>> fetchValutes() async {
    List<Valute> valutes = <Valute>[
      Valute(id: 0, name: 'Lek', symbol: 'L'),
      Valute(id: 1, name: 'Euro', symbol: '€'),
      // TODO: FIX US DOLLAR SYMBOL.
      Valute(id: 0, name: 'US Dollar', symbol: 'US'),
    ];

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => valutes,
    );
  }
}
