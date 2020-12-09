import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, photo: null);

  // ignore: sort_constructors_first
  factory User.fromJson(dynamic json) {
    return User(
      email: json['email'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return '{ "email": "$email", "id": "$id", "name": "$name", "photo": "$photo"  }';
  }

  @override
  List<Object> get props => [email, id, name, photo];
}
