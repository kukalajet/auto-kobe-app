import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'models/models.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    GoogleSignIn googleSignIn,
    @required this.httpClient,
    @required this.storage,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _controller = StreamController<User>() {
    sendUser();
  }

  final GoogleSignIn _googleSignIn;
  final StreamController<User> _controller;
  final http.Client httpClient;
  final FlutterSecureStorage storage;

  void sendUser() async {
    final encodedUser = await storage.read(key: 'user');
    if (encodedUser == null) return _controller.add(User.empty);
    final user = User.fromJson(jsonDecode(encodedUser));
    _controller.add(user);
  }

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _controller.stream.map((user) {
      return user == null ? User.empty : user;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      // await _firebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      await googleUser.authentication.then((key) async {
        final url = 'https://auto24.herokuapp.com/auth/signinwithgoogle';
        final headers = <String, String>{'Content-type': 'application/json'};
        final data = <String, String>{
          'idToken': key.idToken,
          'googleId': _googleSignIn.currentUser.id,
          'email': _googleSignIn.currentUser.email,
          'photoUrl': _googleSignIn.currentUser.photoUrl,
          'name': _googleSignIn.currentUser.displayName,
        };

        final response = await httpClient.post(url,
            headers: headers, body: jsonEncode(data));
        final status = response.statusCode;
        final dynamic body = jsonDecode(response.body);
        if (status == 201) {
          final dynamic accessToken = body['accessToken'];
          final user = User(
            name: _googleSignIn.currentUser.displayName,
            email: _googleSignIn.currentUser.email,
            photo: _googleSignIn.currentUser.photoUrl,
            id: key.idToken,
          );

          _controller.add(user);

          final stringifiedUser = user.toString();
          await storage.write(key: 'accessToken', value: accessToken as String);
          await storage.write(key: 'user', value: stringifiedUser);
        } else {
          throw LogInWithGoogleFailure();
        }
      });
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      // await _firebaseAuth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
