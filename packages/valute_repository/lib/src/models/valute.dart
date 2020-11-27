import 'package:meta/meta.dart';

class Valute {
  const Valute({
    @required this.id,
    @required this.name,
    @required this.symbol,
  });

  final int id;
  final String name;
  final String symbol;

  @override
  String toString() => '{ id: $id, name: $name, symbol: $symbol }';
}
