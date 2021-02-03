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
    @required this.firstName,
    @required this.lastName,
    @required this.photoUrl,
  })  : assert(email != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final int id;

  /// The current user's first name (display name).
  final String firstName;

  /// The current user's last name (display name).
  final String lastName;

  /// Url for the current user's photo.
  final String photoUrl;

  /// Empty user which represents an unauthenticated user.
  static const empty =
      User(email: '', id: -1, firstName: null, lastName: null, photoUrl: null);

  // ignore: sort_constructors_first
  factory User.fromJson(dynamic json) {
    return User(
      email: json['email'] as String,
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      photoUrl: json['photo'] as String,
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return '{ "email": "$email", "id": $id, "firstName": "$firstName", "lastName": "$lastName", "photoUrl": "$photoUrl" }';
  }

  @override
  List<Object> get props => [email, id, firstName, lastName, photoUrl];
}
