import 'package:meta/meta.dart';

import 'condition_type.dart';

class Condition {
  const Condition({
    @required this.id,
    @required this.type,
  });

  final int id;
  final ConditionType type;

  @override
  String toString() => '{ id: $id, type: $type }';
}
