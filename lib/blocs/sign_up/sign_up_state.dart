part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.surname = const Surname.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Surname surname;
  final Email email;
  final Password password;
  final FormzStatus status;

  SignUpState copyWith({
    Name name,
    Surname surname,
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return SignUpState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, surname, email, password];
}

class SignUpInitial extends SignUpState {}
