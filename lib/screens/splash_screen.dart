import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://pbs.twimg.com/profile_images/1352001124295991298/nSMfcPd7_400x400.jpg',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}
