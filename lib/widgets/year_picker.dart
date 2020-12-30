import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YearPicker extends StatefulWidget {
  final Function(DateTime) onConfirm;

  const YearPicker({
    Key key,
    @required this.onConfirm,
  }) : super(key: key);

  @override
  _YearPickerState createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  int currentIndex = 0;

  int year(int index) => (2021 - index);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 300.0,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Choose registration year:',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                  color: Colors.blue.shade200,
                  textColor: Colors.white,
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    final date = DateTime(year(currentIndex), 1, 1);
                    widget.onConfirm(date);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 56.0),
                child: ListWheelScrollView(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  magnification: 1.2,
                  useMagnifier: true,
                  overAndUnderCenterOpacity: .5,
                  onSelectedItemChanged: (int index) =>
                      setState(() => currentIndex = index),
                  children: List.generate(
                    77,
                    (i) => ListTile(
                      tileColor: Colors.white54,
                      title: Center(
                        child: Text(
                          "${year(i)}",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 32.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
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
