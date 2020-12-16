import 'package:meta/meta.dart';

import 'transmission_type.dart';

class Transmission {
  const Transmission({
    @required this.id,
    @required this.type,
  });

  final int id;
  final TransmissionType type;

  @override
  String toString() => '{ id: $id, type: $type }';
}
