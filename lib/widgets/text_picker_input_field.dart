import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// NOTE: A better name?
class TextPickerInputField extends StatelessWidget {
  const TextPickerInputField({
    Key key,
    @required this.textHint,
    @required this.pickerHint,
    @required this.picker,
    @required this.onTextChanged,
    @required this.icon,
    @required this.showOverviewHint,
    this.inputType,
  }) : super(key: key);

  final IconData icon;
  final String textHint;
  final String pickerHint;
  final Widget picker;
  final Function(String) onTextChanged;
  final TextInputType inputType;
  final bool showOverviewHint;

  @override
  Widget build(BuildContext context) {
    final bool hasBottomPadding = MediaQuery.of(context).viewPadding.bottom > 0;
    final Size size = MediaQuery.of(context).size;
    final double height = hasBottomPadding ? size.height * 0.8 : size.height;
    final double width = size.width;
    return Container(
      height: height * 0.1,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffaabbcc).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.fromBorderSide(
          BorderSide(color: const Color(0xffaabbcc), width: 4.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: width * 0.14,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: showOverviewHint
                  ? Text(
                      textHint,
                      style: TextStyle(color: const Color(0xffaabbcc)),
                    )
                  : SizedBox(),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        icon,
                        size: 28,
                        color: Colors.black54,
                      ),
                      hintText: textHint,
                      hintStyle: kBodyTextBlack,
                    ),
                    style: kBodyTextBlack,
                    keyboardType: inputType,
                    onChanged: (text) => onTextChanged(text),
                  ),
                ),
              ),
              Container(
                height: 32.0,
                width: 2.0,
                color: const Color(0xffaabbcc),
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: GestureDetector(
                    onTap: () => showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => picker,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextField(
                        textAlign: TextAlign.right,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.chevron_left,
                              size: 28.0,
                              color: Colors.black54,
                            ),
                          ),
                          hintText: pickerHint,
                          hintStyle: kBodyTextBlack,
                        ),
                        style: kBodyTextBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
