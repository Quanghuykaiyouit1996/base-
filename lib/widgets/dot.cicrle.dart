import 'package:flutter/material.dart';

class DotCircular extends StatelessWidget {
  final Color color;
  final Size? size;
  final double? topMarginDot;

  const DotCircular(
      {Key? key, this.color = Colors.green, this.size, this.topMarginDot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size!.height,
        width: size!.width,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: color,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}
