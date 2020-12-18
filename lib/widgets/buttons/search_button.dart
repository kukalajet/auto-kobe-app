import 'package:auto_kobe/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        onTap: () => showMaterialModalBottomSheet(
          context: context,
          builder: (context) => picker,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.indigoAccent.withOpacity(0.9),
                width: 4.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Text(
                  'SEARCH',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Icon(Icons.search, size: 28, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
