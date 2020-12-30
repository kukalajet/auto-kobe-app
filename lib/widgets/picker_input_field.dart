import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_kobe/utils/palette.dart';

class PickerInputField extends StatelessWidget {
  const PickerInputField({
    Key key,
    @required this.picker,
    @required this.icon,
    @required this.hint,
    @required this.value,
    this.expand = false,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final String value;
  final Widget picker;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 72,
      width: width * 0.9,
      child: GestureDetector(
        onTap: () => showCupertinoModalBottomSheet(
          expand: expand,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => picker,
        ),
        child: Container(
          width: width * 0.9,
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
                    left: width * 0.13,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: value != null
                          ? Text(
                              hint,
                              style: TextStyle(color: const Color(0xffaabbcc)),
                            )
                          : SizedBox(),
                    ),
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        icon,
                        size: 28.0,
                        color: Colors.black54,
                      ),
                      suffixIcon: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.chevron_left,
                          size: 28.0,
                          color: Colors.black54,
                        ),
                      ),
                      hintText: value != null ? value : hint,
                      hintStyle: kBodyTextBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
