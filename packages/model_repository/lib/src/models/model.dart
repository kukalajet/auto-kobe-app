import 'package:meta/meta.dart';

class Model {
  final int id;
  final String name;

  const Model({
    @required this.id,
    @required this.name,
  });

  @override
  String toString() {
    return '{ id: $id, name: $name }';
  }
}
