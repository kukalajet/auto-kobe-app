import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Register',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.indigo[800].withOpacity(0.9),
                    fontSize: 48.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              BlocProvider<SignUpCubit>(
                create: (_) => SignUpCubit(
                  context.read<AuthenticationRepository>(),
                ),
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
