import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_kobe/utils/palette.dart';

class PickerInputField extends StatelessWidget {
  const PickerInputField({
    Key key,
    @required this.picker,
    @required this.icon,
    @required this.hint,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final Widget picker;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.9,
        child: GestureDetector(
          onTap: () => showCupertinoModalBottomSheet(
            expand: true,
            bounce: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => picker,
          ),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.red[200].withOpacity(0.45),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      icon,
                      size: 28.0,
                      color: kWhite,
                    ),
                    suffixIcon: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.chevron_left,
                        size: 28.0,
                        color: kWhite,
                      ),
                    ),
                    hintText: hint,
                    hintStyle: kBodyText,
                  ),
                  style: kBodyText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
