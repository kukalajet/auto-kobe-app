import 'package:meta/meta.dart';

class Date {
  final int day;
  final int month;
  final int year;

  const Date({
    @required this.day,
    @required this.month,
    @required this.year,
  });

  static Date upperValue() => Date(day: 1, month: 1, year: 2021);
  static Date lowerValue() => Date(day: 1, month: 1, year: 1990);

  @override
  String toString() => '$day / $month / $year';
}
