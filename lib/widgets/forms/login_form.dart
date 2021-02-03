import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          _GoogleLoginButton(),
          _FacebookLoginButton(),
          _AppleLoginButton(),
          const SizedBox(height: 24.0),
          _EmailInput(),
          _PasswordInput(),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Container(
        width: double.infinity,
        height: 52.0,
        child: RaisedButton(
          color: Colors.red.withOpacity(0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.red),
          ),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.google, color: Colors.white),
              Spacer(),
              Text(
                'SIGN IN WITH GOOGLE',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer()
            ],
          ),
          onPressed: () => context.watch<LoginCubit>().logInWithGoogle(),
        ),
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Container(
        width: double.infinity,
        height: 52.0,
        child: RaisedButton(
          color: Colors.blue.withOpacity(0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.blue),
          ),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.facebookF, color: Colors.white),
              Spacer(),
              Text(
                'SIGN IN WITH FACEBOOK',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer()
            ],
          ),
          onPressed: () => context.watch<LoginCubit>().logInWithGoogle(),
        ),
      ),
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Container(
        width: double.infinity,
        height: 52.0,
        child: RaisedButton(
          color: Colors.black.withOpacity(0.65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.black12),
          ),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.apple, color: Colors.white),
              Spacer(),
              Text(
                'SIGN IN WITH APPLE',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer()
            ],
          ),
          onPressed: () => context.watch<LoginCubit>().logInWithGoogle(),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: TextInputField(
            icon: Icons.email,
            hint: "EMAIL",
            showOverviewHint: false,
            inputType: TextInputType.emailAddress,
            height: 64.0,
            onTextChanged: (String email) =>
                context.read<LoginCubit>().emailChanged(email),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: TextInputField(
            icon: Icons.vpn_key,
            hint: "PASSWORD",
            showOverviewHint: false,
            inputType: TextInputType.visiblePassword,
            height: 64.0,
            obscureText: state.password.value.isEmpty,
            onTextChanged: (String password) =>
                context.read<LoginCubit>().passwordChanged(password),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    height: 52.0,
                    child: RaisedButton(
                      color: Colors.blueGrey.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      child: Text(
                        'SIGN IN WITH EMAIL',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: state.status.isValidated
                          ? () =>
                              context.read<LoginCubit>().logInWithCredentials()
                          : null,
                    ),
                  ),
                );
        });
  }
}
