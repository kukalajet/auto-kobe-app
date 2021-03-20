import 'package:auto_kobe/widgets/widgets.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_kobe/blocs/blocs.dart';
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
          const SizedBox(height: 24.0),
          _EmailInput(),
          _PasswordInput(),
          const SizedBox(height: 8.0),
          _LoginButton(),
          const SizedBox(height: 8.0),
          _SocialButtons(),
        ],
      ),
    );
  }
}

class _SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: AppDivider(height: 1.0, padding: 32.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleLoginButton(),
            _FacebookLoginButton(),
            _AppleLoginButton(),
          ],
        ),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Google,
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Facebook,
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      ),
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Apple,
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
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
        if (state.status.isSubmissionFailure) {
          Flushbar(
            flushbarStyle: FlushbarStyle.GROUNDED,
            flushbarPosition: FlushbarPosition.TOP,
            title: "Regjistrohu ose logohu",
            message:
                "Për të aksesuar produktet ne aplikacion, duhet të logoheni",
            duration: Duration(seconds: 3),
          )..show(context);
        }

        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  height: 52.0,
                  child: RaisedButton(
                    color: ColorConstant.primary,
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
      },
    );
  }
}
