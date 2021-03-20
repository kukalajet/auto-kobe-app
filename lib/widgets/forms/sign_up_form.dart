import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/sign_up/sign_up.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24.0),
          _FirstNameInput(),
          _LastNameInput(),
          _EmailInput(),
          _PasswordInput(),
          const SizedBox(height: 8.0),
          _SignUpButton(),
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
            _GoogleSignupButton(),
            _FacebookSignupButton(),
            _AppleSignupButton(),
          ],
        ),
      ],
    );
  }
}

class _GoogleSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Google,
        // onPressed: () => context.read<SignUpCubit>().logInWithGoogle(),
        onPressed: () => {},
      ),
    );
  }
}

class _FacebookSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Facebook,
        // onPressed: () => context.read<SignUpCubit>().logInWithGoogle(),
        onPressed: () => {},
      ),
    );
  }
}

class _AppleSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SocialButton(
        social: Social.Apple,
        // onPressed: () => context.read<SignUpCubit>().logInWithGoogle(),
        onPressed: () => {},
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: TextInputField(
            icon: Icons.email,
            hint: "FIRST NAME",
            showOverviewHint: false,
            inputType: TextInputType.name,
            height: 64.0,
            onTextChanged: (String name) =>
                context.read<SignUpCubit>().nameChanged(name),
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: TextInputField(
            icon: Icons.email,
            hint: "LAST NAME",
            showOverviewHint: false,
            inputType: TextInputType.name,
            height: 64.0,
            onTextChanged: (String lastName) =>
                context.read<SignUpCubit>().surnameChanged(lastName),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                context.read<SignUpCubit>().emailChanged(email),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                context.read<SignUpCubit>().passwordChanged(password),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  height: 52.0,
                  child: RaisedButton(
                    color: Colors.blueGrey.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    child: Text(
                      'REGISTER WITH EMAIL',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: state.status.isValidated
                        ? () =>
                            context.read<SignUpCubit>().signUpFormSubmitted()
                        : null,
                  ),
                ),
              );
      },
    );
  }
}
