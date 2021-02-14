import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.onTextChanged,
    this.showOverviewHint,
    this.suffixText,
    this.inputType,
    this.inputAction,
    this.height,
    this.obscureText,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final bool showOverviewHint;
  final String suffixText;
  final Function(String) onTextChanged;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final double height;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: this.height ?? 64.0,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: showOverviewHint == true
            ? ColorConstant.success.withOpacity(0.05)
            : ColorConstant.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.fromBorderSide(
          BorderSide(
            width: 4.0,
            color: showOverviewHint == true
                ? ColorConstant.success.withOpacity(0.3)
                : ColorConstant.primary.withOpacity(0.3),
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 50.0,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: showOverviewHint
                      ? Text(hint, style: TextStyle(color: Colors.black45))
                      : SizedBox(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon, size: 28.0, color: Colors.black54),
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(suffixText ?? ''),
                  ),
                  hintText: hint,
                  hintStyle: kBodyTextBlack,
                ),
                style: kBodyTextBlack,
                keyboardType: inputType,
                obscureText: this.obscureText ?? false,
                onChanged: (text) => onTextChanged(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
