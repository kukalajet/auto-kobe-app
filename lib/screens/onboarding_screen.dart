import 'package:auto_kobe/screens/screens.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => OnboardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://media.giphy.com/media/3ov9jWu7BuHufyLs7m/giphy.gif",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              data: 'START',
              color: Colors.black.withOpacity(0.6),
              verticalPadding: 64.0,
              horizontalPadding: 40.0,
              height: 48.0,
              circularRadius: 24.0,
              onPressed: () =>
                  Navigator.of(context).push<void>(PreviewScreen.route()),
            ),
          ),
        ],
      ),
    );
  }
}
