import 'package:meta/meta.dart';

//? SHOULD WE HAVE A REPOSITORY FOR THIS?
class Type {
  final int id;
  final String name;

  const Type({
    @required this.id,
    @required this.name,
  });

  @override
  String toString() => '{ id: $id, name: $name }';
}
