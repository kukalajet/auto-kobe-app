import 'package:auto_kobe/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FeedTypeButton extends StatelessWidget {
  const FeedTypeButton({
    Key key,
    @required this.icon,
    @required this.picker,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final IconData icon;
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
          builder: (context, scrollController) => picker,
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
                prefixIcon: Icon(
                  // Icons.search,
                  icon,
                  size: 28.0,
                  color: Colors.white70,
                ),
                suffixIcon: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.chevron_left,
                    size: 28.0,
                    color: Colors.white70,
                  ),
                ),
                hintStyle: kBodyTextWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
