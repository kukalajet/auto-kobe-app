import 'package:flutter/material.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerInputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final Function(DateTime) onConfirmed;

  const DatePickerInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.onConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      width: size.width * 0.9,
      child: GestureDetector(
        onTap: () => DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 3, 5),
          maxTime: DateTime(2019, 6, 7),
          onChanged: (date) => print('change $date'),
          onConfirm: (date) => onConfirmed(date),
          currentTime: DateTime.now(),
          locale: LocaleType.sq,
        ),
        child: Container(
          height: size.height * 0.08,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            // color: Colors.red[200].withOpacity(0.45),
            color: const Color(0xffaabbcc).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
            // border: Border.fromBorderSide(
            //   BorderSide(color: Colors.red, width: 4.0),
            // ),
            border: Border.fromBorderSide(
              // #5c6bc0
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
                    // color: kWhite,
                    color: Colors.black54,
                  ),
                  suffixIcon: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.chevron_left,
                      size: 28.0,
                      // color: kWhite,
                      color: Colors.black54,
                    ),
                  ),
                  hintText: hint,
                  hintStyle: kBodyTextBlack,
                ),
                style: kBodyTextBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
