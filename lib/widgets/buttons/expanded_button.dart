import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({
    @required this.data,
    this.color,
    this.textColor,
    this.onTap,
    this.fontSize,
    this.fontWeight,
  });

  final Color color;
  final Function onTap;
  final String data;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: this.color,
      child: InkWell(
        onTap: this.onTap,
        child: Center(
          child: Text(
            this.data,
            style: GoogleFonts.lato(
              color: this.textColor ?? Colors.white,
              fontSize: this.fontSize ?? 28.0,
              fontWeight: this.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
