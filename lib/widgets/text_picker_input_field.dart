import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// NOTE: A better name?
class TextPickerInputField extends StatelessWidget {
  final IconData icon;
  final String textInputHint;
  final String pickerInputHint;
  final Widget picker;
  final TextInputType inputType;

  const TextPickerInputField({
    Key key,
    @required this.textInputHint,
    @required this.pickerInputHint,
    @required this.picker,
    @required this.icon,
    this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.blue[100].withOpacity(0.45),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
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
                    hintText: textInputHint,
                    hintStyle: kBodyText,
                  ),
                  style: kBodyText,
                  keyboardType: inputType,
                ),
              ),
            ),
            Container(
              height: 32.0,
              width: 2.0,
              color: Colors.white30,
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GestureDetector(
                  onTap: () => {
                    showCupertinoModalBottomSheet(
                      expand: true,
                      bounce: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context, scrollController) => picker,
                    )
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.chevron_left,
                            size: 28.0,
                            color: kWhite,
                          ),
                        ),
                        hintText: pickerInputHint,
                        hintStyle: kBodyText,
                      ),
                      style: kBodyText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
