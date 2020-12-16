import 'package:meta/meta.dart';

class Emission {
  const Emission({
    @required this.id,
    @required this.standard,
    @required this.tier,
  });

  final int id;
  final String standard;
  final int tier;

  @override
  String toString() => '{ id: $id, standard: $standard, tier: $tier }';
}
