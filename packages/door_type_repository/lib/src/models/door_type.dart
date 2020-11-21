import 'package:meta/meta.dart';

class DoorType {
  final int id;
  final String number;

  const DoorType({
    @required this.id,
    @required this.number,
  });

  @override
  String toString() => '{ id: $id, name: $number }';
}
