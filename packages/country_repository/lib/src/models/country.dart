import 'package:meta/meta.dart';

class Country {
  final int id;
  final String name;
  final String image;

  const Country({
    @required this.id,
    @required this.name,
    @required this.image,
  });

  @override
  String toString() => '{ id: $id, name: $name, image: $image }';
}
