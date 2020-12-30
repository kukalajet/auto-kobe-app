import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:auto_kobe/widgets/widgets.dart' as widget;

class DatePickerInputField extends StatelessWidget {
  const DatePickerInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.value,
    @required this.onConfirmed,
    @required this.showOverviewHint,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final String value;
  final Function(DateTime) onConfirmed;
  final bool showOverviewHint;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 72.0,
      width: width * 0.9,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: width * 0.155,
            top: 5,
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
          GestureDetector(
            onTap: () => showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => widget.YearPicker(
                onConfirm: (date) => onConfirmed(date),
              ),
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
                  child: TextField(
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
                      hintText: showOverviewHint ? value : hint,
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
    );
  }
}
