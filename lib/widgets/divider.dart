import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double height;
  final double padding;

  const AppDivider({
    this.height = 1.0,
    this.padding = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.primaryVariant.withOpacity(0.25),
      ),
    );
  }
}
