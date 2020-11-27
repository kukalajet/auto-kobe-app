import 'package:meta/meta.dart';
import 'models.dart';

class Price {
  const Price({
    @required this.value,
    @required this.valute,
  });

  final int value;
  final Valute valute;

  @override
  String toString() => '{ value: $value, valute: $valute }';
}
