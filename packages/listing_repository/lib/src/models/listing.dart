import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Listing extends Equatable {
  const Listing({
    @required this.id,
    @required this.title,
    @required this.body,
  });

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];
}
