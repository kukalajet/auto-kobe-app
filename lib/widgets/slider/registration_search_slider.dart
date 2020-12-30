import 'package:auto_kobe/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_repository/listing_repository.dart';

class RegistrationSearchSlider extends StatefulWidget {
  const RegistrationSearchSlider({@required this.context});

  final BuildContext context;

  @override
  _RegistrationSearchSliderState createState() =>
      _RegistrationSearchSliderState();
}

class _RegistrationSearchSliderState extends State<RegistrationSearchSlider> {
  RangeValues _values;
  RangeLabels _labels;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(lowerValue.toDouble(), upperValue.toDouble());
    _labels = RangeLabels(lowerValue.toString(), upperValue.toString());
  }

  int get lowerValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.registration.value.isEmpty) return Date.lowerValue().year;
    return state.registration.value[0].year;
  }

  int get upperValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.registration.value.isEmpty) return Date.upperValue().year;
    return state.registration.value[1].year;
  }

  Widget _buildMessage(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Choose registration years range:',
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
            final lowerValue = _values.start.toInt();
            final upperValue = _values.end.toInt();
            Date lowerLimit = Date(day: 1, month: 1, year: lowerValue);
            Date upperLimit = Date(day: 1, month: 1, year: upperValue);

            context.read<SearchBloc>()
              ..add(SearchRegistrationChanged(lowerLimit, upperLimit));

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    final state = widget.context.read<SearchBloc>().state;

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
              divisions: Date.upperValue().year - Date.lowerValue().year,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(.5),
              min: Date.lowerValue().year.toDouble(),
              max: Date.upperValue().year.toDouble(),
              values: _values,
              labels: _labels,
              onChanged: (value) {
                setState(() {
                  _values = value;
                  _labels = RangeLabels(
                    value.start.toInt().toString(),
                    value.end.toInt().toString(),
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
