import 'models/models.dart';

class ConditionRepository {
  Future<List<Condition>> fetchConditions() async {
    List<Condition> condition = <Condition>[
      Condition(id: 0, type: ConditionType.Excelent),
      Condition(id: 1, type: ConditionType.Good),
      Condition(id: 2, type: ConditionType.Damaged),
    ];

    return condition;
  }
}
