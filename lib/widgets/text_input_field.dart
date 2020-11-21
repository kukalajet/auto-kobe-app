import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.onTextChanged,
    this.suffixText,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final String suffixText;
  final Function(String) onTextChanged;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.45),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  icon,
                  size: 28,
                  color: kWhite,
                ),
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(suffixText ?? ''),
                ),
                hintText: hint,
                hintStyle: kBodyText,
              ),
              style: kBodyText,
              keyboardType: inputType,
              onChanged: (text) => onTextChanged(text),
            ),
          ),
        ),
      ),
    );
  }
}
