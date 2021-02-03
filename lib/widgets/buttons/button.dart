import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    @required this.data,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.onPressed,
    this.verticalPadding,
    this.horizontalPadding,
    this.fontSize,
    this.circularRadius,
    this.fontWeight,
  });

  final String data;
  final Color textColor;
  final double fontSize;
  final double width;
  final double height;
  final Color color;
  final Function onPressed;
  final double verticalPadding;
  final double horizontalPadding;
  final double circularRadius;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: this.verticalPadding,
        horizontal: this.horizontalPadding,
      ),
      child: Container(
        width: this.width ?? double.infinity,
        height: this.height ?? 40.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.circularRadius ?? 18.0),
            side: BorderSide(color: this.color ?? Colors.red),
          ),
          onPressed: this.onPressed,
          color: this.color ?? Colors.red,
          child: Text(
            this.data,
            style: GoogleFonts.lato(
              color: this.textColor ?? Colors.white,
              fontSize: this.fontSize ?? 22.0,
              fontWeight: this.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
