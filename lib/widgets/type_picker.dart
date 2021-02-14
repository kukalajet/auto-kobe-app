import 'package:auto_kobe/models/models.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';

class TypePicker extends StatefulWidget {
  final Function(Type type) onTypeSelected;

  const TypePicker({
    Key key,
    @required this.onTypeSelected,
  }) : super(key: key);

  @override
  _TypePickerState createState() => _TypePickerState();
}

class _TypePickerState extends State<TypePicker> {
  int indexTypeSelected;
  List<Type> _types = [
    Type(id: 0, name: 'car'),
    Type(id: 1, name: 'motorcycle'),
    Type(id: 2, name: 'truck'),
    Type(id: 3, name: 'bicycle'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TypePickerItem(
          icon: Icon(Icons.access_alarm, size: 30),
          tapped: indexTypeSelected == 0,
          onTypeSelected: () {
            setState(() => indexTypeSelected = 0);
            widget.onTypeSelected(_types[0]);
          },
        ),
        _TypePickerItem(
          icon: Icon(Icons.ac_unit, size: 30),
          tapped: indexTypeSelected == 1,
          onTypeSelected: () {
            setState(() => indexTypeSelected = 1);
            widget.onTypeSelected(_types[1]);
          },
        ),
        _TypePickerItem(
          icon: Icon(Icons.ac_unit, size: 30),
          tapped: indexTypeSelected == 2,
          onTypeSelected: () {
            setState(() => indexTypeSelected = 2);
            widget.onTypeSelected(_types[2]);
          },
        ),
        _TypePickerItem(
          icon: Icon(Icons.ac_unit, size: 30),
          tapped: indexTypeSelected == 3,
          onTypeSelected: () {
            setState(() => indexTypeSelected = 3);
            widget.onTypeSelected(_types[3]);
          },
        ),
      ],
    );
  }
}

class _TypePickerItem extends StatelessWidget {
  final Icon icon;
  final bool tapped;
  final Function() onTypeSelected;

  const _TypePickerItem({
    Key key,
    @required this.icon,
    @required this.tapped,
    @required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: tapped
            ? ColorConstant.success.withOpacity(0.66)
            : ColorConstant.primary, // Colors.red,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: icon,
        ),
      ),
      onPressed: () => onTypeSelected(),
    );
  }
}
