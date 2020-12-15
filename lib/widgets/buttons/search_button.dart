import 'package:auto_kobe/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
    @required this.picker,
    @required this.width,
    this.height,
  }) : super(key: key);

  final Widget picker;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => picker,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.indigo,
            // borderRadius: BorderRadius.circular(16.0),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.indigoAccent.withOpacity(0.9),
                width: 4.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  size: 28.0,
                  color: Colors.white70,
                ),
                hintText: 'SEARCH',
                hintStyle: kBodyTextWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
