import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SearchType extends Equatable {
  const SearchType({
    @required this.id,
    @required this.title,
  });

  final int id;
  final String title;

  @override
  List<Object> get props => [id, title];
}
