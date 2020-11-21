import 'package:meta/meta.dart';

class Brand {
  final int id;
  final String name;

  const Brand({
    @required this.id,
    @required this.name,
  });

  @override
  String toString() => "{ id: $id, name: $name }";
}
