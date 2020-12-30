import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  AppSlider({
    this.height = 48,
    this.max = 10,
    this.min = 0,
    this.fullWidth = false,
  });

  final double height;
  final int min;
  final int max;
  final bool fullWidth;

  @override
  _AppSliderState createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  RangeValues values = RangeValues(1, 1000);
  RangeLabels labels = RangeLabels('1', '1000');

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
      ),
      child: Center(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00c6ff),
                const Color(0xFF0072ff),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: RangeSlider(
            divisions: 100,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(.5),
            min: 1,
            max: 1000,
            values: values,
            labels: labels,
            onChanged: (value) {
              print('START: ${value.start}, END: ${value.end}');
              setState(() {
                values = value;
                labels = RangeLabels("${value.start.toInt().toString()}\$",
                    "${value.end.toInt().toString()}\$");
              });
            },
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   double paddingFactor = .2;
  //   if (this.widget.fullWidth) paddingFactor = .3;

  //   return Container(
  //     width:
  //         this.widget.fullWidth ? double.infinity : (this.widget.height) * 5.5,
  //     height: this.widget.height,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(this.widget.height * .3),
  //       ),
  //       gradient: LinearGradient(
  //         colors: [
  //           const Color(0xFF00c6ff),
  //           const Color(0xFF0072ff),
  //         ],
  //         begin: const FractionalOffset(0.0, 0.0),
  //         end: const FractionalOffset(1.0, 1.0),
  //         stops: [0.0, 1.0],
  //         tileMode: TileMode.clamp,
  //       ),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         vertical: 2.0,
  //         horizontal: this.widget.height * paddingFactor,
  //       ),
  //       child: Row(
  //         children: <Widget>[
  //           Text(
  //             '${this.widget.min} KM',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: this.widget.height * .3,
  //               fontWeight: FontWeight.w700,
  //               color: Colors.white,
  //             ),
  //           ),
  //           SizedBox(width: this.widget.height * 0.1),
  //           Expanded(
  //             child: Center(
  //               child: SliderTheme(
  //                 data: SliderTheme.of(context).copyWith(
  //                   activeTrackColor: Colors.white.withOpacity(1.0),
  //                   inactiveTrackColor: Colors.white.withOpacity(.5),
  //                   trackHeight: 4.0,
  //                   // rangeThumbShape: _CustomSliderThumbCircle(
  //                   //   radius: this.widget.height * .25,
  //                   //   min: this.widget.min,
  //                   //   max: this.widget.max,
  //                   // ),
  //                   overlayColor: Colors.white.withOpacity(.4),
  //                   activeTickMarkColor: Colors.white,
  //                   inactiveTickMarkColor: Colors.red.withOpacity(.7),
  //                 ),
  //                 child: RangeSlider(
  //                   values: _values,
  //                   onChanged: (RangeValues values) {
  //                     setState(() {
  //                       _values = values;
  //                     });
  //                   },
  //                 ),
  //                 // ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(width: this.widget.height * .1),
  //           Text(
  //             '${this.widget.max} KM',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: this.widget.height * .3,
  //               fontWeight: FontWeight.w700,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// class _CustomSliderThumbCircle extends SliderComponentShape {
// class _CustomSliderThumbCircle extends RangeSliderThumbShape {
//   const _CustomSliderThumbCircle({
//     @required this.radius,
//     this.min = 0,
//     this.max = 10,
//   });

//   final double radius;
//   final int min;
//   final int max;

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
//       Size.fromRadius(radius);

//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     Animation<double> activationAnimation,
//     Animation<double> enableAnimation,
//     bool isDiscrete,
//     bool isEnabled,
//     bool isOnTop,
//     TextDirection textDirection,
//     SliderThemeData sliderTheme,
//     Thumb thumb,
//     bool isPressed,
//   }) {
//     final Canvas canvas = context.canvas;

//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     TextSpan span = TextSpan(
//       style: TextStyle(
//         fontSize: radius * .8,
//         fontWeight: FontWeight.w700,
//         color: sliderTheme.thumbColor,
//       ),
//       // text: getValue(value),
//     );

//     TextPainter tp = TextPainter(
//       text: span,
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//     tp.layout();

//     Offset textCenter =
//         Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

//     canvas.drawCircle(center, radius * .9, paint);
//     tp.paint(canvas, textCenter);
//   }

//   String getValue(double value) =>
//       (min + (max - min) * value).round().toString();
// }
