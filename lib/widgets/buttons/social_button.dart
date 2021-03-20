import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Social {
  Apple,
  Facebook,
  Google,
}

class SocialButton extends StatelessWidget {
  final Social social;
  final Function onPressed;

  const SocialButton({
    Key key,
    @required this.social,
    @required this.onPressed,
  });

  get icon {
    switch (this.social) {
      case Social.Apple:
        return Icon(FontAwesomeIcons.apple, color: Colors.white);
      case Social.Facebook:
        return Icon(FontAwesomeIcons.facebook, color: Colors.white);
      case Social.Google:
        return Icon(FontAwesomeIcons.google, color: Colors.white);
    }
  }

  get color {
    switch (this.social) {
      case Social.Apple:
        return Colors.black.withOpacity(0.65);
      case Social.Facebook:
        return Colors.blue.withOpacity(0.75);
      case Social.Google:
        return Colors.red.withOpacity(0.75);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      shape: CircleBorder(),
      onPressed: this.onPressed,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: icon,
      ),
    );
  }
}
