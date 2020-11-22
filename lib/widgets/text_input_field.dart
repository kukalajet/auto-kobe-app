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
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final bool showOverviewHint;
  final String suffixText;
  final Function(String) onTextChanged;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffaabbcc).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.fromBorderSide(
          BorderSide(color: const Color(0xffaabbcc), width: 4.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: size.width * 0.13,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: showOverviewHint
                      ? Text(
                          hint,
                          style: TextStyle(color: const Color(0xffaabbcc)),
                        )
                      : SizedBox(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    icon,
                    size: 28,
                    color: Colors.black54,
                  ),
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(suffixText ?? ''),
                  ),
                  hintText: hint,
                  hintStyle: kBodyTextBlack,
                ),
                style: kBodyTextBlack,
                keyboardType: inputType,
                onChanged: (text) => onTextChanged(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
