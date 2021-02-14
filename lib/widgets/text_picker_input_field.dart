import 'package:constant_repository/constant_repository.dart';
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
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 64.0,
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
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 56.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: showOverviewHint
                    ? Text(
                        textHint,
                        style: TextStyle(color: Colors.black45),
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
                  color: ColorConstant.primary.withOpacity(0.4),
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
      ),
    );
  }
}
