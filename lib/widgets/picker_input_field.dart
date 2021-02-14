import 'package:constant_repository/constant_repository.dart';
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
      height: 64,
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
            color: value != null
                ? ColorConstant.success.withOpacity(0.05)
                : ColorConstant.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.fromBorderSide(
              BorderSide(
                color: value != null
                    ? ColorConstant.success.withOpacity(0.3)
                    : ColorConstant.primaryVariant.withOpacity(0.3),
                width: 4.0,
              ),
            ),
          ),
          child: Stack(
            children: [
              _buildHint(context),
              _buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHint(BuildContext context) {
    return Positioned(
      left: 50.0,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: value != null
            ? Text(
                hint,
                style: TextStyle(color: Colors.black54),
              )
            : SizedBox(),
      ),
    );
  }

  Widget _buildInput() {
    return Center(
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, size: 28.0, color: Colors.black54),
          suffixIcon: Icon(Icons.keyboard_arrow_down,
              size: 28.0, color: Colors.black54),
          hintText: value != null ? value : hint,
          hintStyle: kBodyTextBlack,
        ),
      ),
    );
  }
}
