import 'package:meta/meta.dart';

class FuelType {
  final int id;
  final String type;

  const FuelType({
    @required this.id,
    @required this.type,
  });

  @override
  String toString() => '{ id: $id, type: $type }';
}
