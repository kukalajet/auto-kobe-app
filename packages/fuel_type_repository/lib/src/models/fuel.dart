import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:meta/meta.dart';

class Fuel {
  final int id;
  final FuelType type;

  const Fuel({
    @required this.id,
    @required this.type,
  });

  @override
  String toString() => '{ id: $id, type: $type }';
}
