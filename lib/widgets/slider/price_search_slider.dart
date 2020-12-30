import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valute_repository/valute_repository.dart';

class PriceSearchSlider extends StatefulWidget {
  const PriceSearchSlider({@required this.context});

  // We pass the context to access the blocs because
  // modal creates another route.
  // https://github.com/jamesblasco/modal_bottom_sheet/issues/123
  final BuildContext context;

  @override
  _PriceSearchSliderState createState() => _PriceSearchSliderState();
}

class _PriceSearchSliderState extends State<PriceSearchSlider> {
  RangeValues _values;
  RangeLabels _labels;
  double _max;

  @override
  void initState() {
    super.initState();
    final state = widget.context.read<SearchBloc>().state;
    final isLeke = state.price.value[0].valute.id == Valute.leke().id;
    final start = isLeke ? _toLeke(lowerValue) : lowerValue.toInt();
    final end =
        isLeke ? _toLeke(upperValueForValute) : upperValueForValute.toInt();
    final valute = isLeke
        ? state.price.value[0].valute.name
        : state.price.value[0].valute.symbol;

    _values = RangeValues(lowerValue, upperValueForValute);
    _labels = RangeLabels('$start $valute', '$end $valute');
    _max = maxValue;
  }

  double get lowerValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.price.value.isEmpty) return 0;
    return state.price.value[0].value;
  }

  double get upperValue {
    final state = widget.context.read<SearchBloc>().state;
    if (state.price.value.isEmpty) return double.infinity;
    return state.price.value[1].value;
  }

  double get upperValueForValute {
    final state = widget.context.read<SearchBloc>().state;
    final valute = state.price.value[0].valute;
    if (upperValue != double.infinity) return upperValue;
    if (valute.id == Valute.leke().id) return 50000000;
    return 50000;
  }

  double get maxValue {
    final state = widget.context.read<SearchBloc>().state;
    final valute = state.price.value[0].valute;
    if (valute.id == Valute.leke().id) return 50000000;
    return 50000;
  }

  int get division => 50;
  String _toLeke(final value) => '${(value / 1000000).toInt()}M';

  Widget _buildMessage(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Choose price range:',
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
            final state = context.read<SearchBloc>().state;
            Price lowerLimit = Price(
              value: _values.start,
              valute: state.price.value[0].valute,
            );
            Price upperLimit = Price(
              value: _values.end,
              valute: state.price.value[1].valute,
            );

            context.read<SearchBloc>()
              ..add(SearchPriceChanged(lowerLimit, upperLimit));

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
              divisions: division,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(.5),
              min: 0,
              max: _max,
              values: _values,
              labels: _labels,
              onChanged: (value) {
                final isLeke =
                    state.price.value[0].valute.id == Valute.leke().id;
                final start =
                    isLeke ? _toLeke(value.start) : value.start.toInt();
                final end = isLeke ? _toLeke(value.end) : value.end.toInt();
                final valute = isLeke
                    ? state.price.value[0].valute.name
                    : state.price.value[0].valute.symbol;

                setState(() {
                  _values = value;
                  _labels = RangeLabels(
                    "$start $valute",
                    "$end $valute",
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValutePicker(BuildContext context) {
    final state = context.read<SearchBloc>().state;

    return PickerInputField(
      icon: Icons.add_link,
      hint: 'VALUTE',
      value: state.price.value.first.valute.id != null
          ? state.price.value.first.valute.name
          : null,
      picker: ListingValutesList(
        onTap: (valute) {
          Price lowerLimit = Price(
            value:
                state.price.value.isNotEmpty ? state.price.value[0].value : 0.0,
            valute: valute,
          );
          Price upperLimit = Price(
            value:
                state.price.value.isNotEmpty ? state.price.value[1].value : 0.0,
            valute: valute,
          );

          context.read<SearchBloc>()
            ..add(SearchPriceChanged(lowerLimit, upperLimit));
          final isLeke = valute.id == Valute.leke().id;

          // call `setState` to update `PriceSearchSlider` value from bloc
          setState(() {
            _max = maxValue;
          });

          Navigator.pop(context);
        },
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
              _buildValutePicker(widget.context),
              _buildSlider(widget.context),
            ],
          ),
        ),
      ),
    );
  }
}
