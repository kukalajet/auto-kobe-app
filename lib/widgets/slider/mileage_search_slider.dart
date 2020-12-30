import 'package:flutter/material.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MileageSearchSlider extends StatefulWidget {
  const MileageSearchSlider({@required this.context});

  final BuildContext context;

  @override
  _MileageSearchSliderState createState() => _MileageSearchSliderState();
}

class _MileageSearchSliderState extends State<MileageSearchSlider> {
  RangeValues _values;
  RangeLabels _labels;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(lowerValue.toDouble(), upperValue.toDouble());
    _labels = RangeLabels(lowerValue.toInt().toString() + ' KM',
        upperValue.toInt().toString() + ' KM');
  }

  double get lowerPossibleValue => 0;
  double get highestPossibleValue => 500000;

  double get lowerValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.mileage.value.isEmpty) return lowerPossibleValue;
    return state.mileage.value[0];
  }

  double get upperValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.mileage.value.isEmpty) return highestPossibleValue;
    return state.mileage.value[1];
  }

  Widget _buildMessage(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Choose mileage range:',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black45,
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, right: 8.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          color: const Color(0xFF0072ff),
          child: Text(
            'SUBMIT',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          onPressed: () {
            final lowerValue = _values.start;
            final upperValue = _values.end;

            context.read<SearchBloc>()
              ..add(SearchMileageChanged(lowerValue, upperValue));

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: SliderTheme(
        data: SliderThemeData(trackHeight: 2),
        child: Center(
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                colors: [const Color(0xFF00c6ff), const Color(0xFF0072ff)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: RangeSlider(
              divisions: highestPossibleValue ~/ 10000,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(.5),
              // min: Date.lowerValue().year.toDouble(),
              min: lowerPossibleValue,
              // max: Date.upperValue().year.toDouble(),
              max: highestPossibleValue,
              values: _values,
              labels: _labels,
              onChanged: (value) {
                setState(() {
                  _values = value;
                  _labels = RangeLabels(
                    value.start.toInt().toString() + ' KM',
                    value.end.toInt().toString() + ' KM',
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  _buildMessage(widget.context),
                  _buildSubmit(widget.context),
                ],
              ),
              _buildSlider(widget.context),
            ],
          ),
        ),
      ),
    );
  }
}
