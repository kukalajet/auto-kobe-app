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

  @override
  String toString() => '$day / $month / $year';
}
