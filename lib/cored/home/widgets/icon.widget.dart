import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Function function;
  final String text;
  final Color? textColor;
  final Color iconColorDisable;
  final Color iconColorEnable;
  final TextStyle? textStyle;
  final double iconSize;
  final IconData? icon;
  final Widget? iconWidget;
  final double space;
  final double textLineHeight;
  final double textSize;
  final bool enable;

  CustomIcon({
    required this.function,
    required this.text,
    this.iconColorDisable = Colors.grey,
    this.iconColorEnable = Colors.green,
    this.textStyle,
    this.icon,
    this.textColor,
    this.iconSize = 21,
    this.space = 3.0,
    this.textLineHeight = 16,
    this.textSize = 16,
    this.enable = true,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget ??
                Icon(
                  icon ?? Icons.set_meal_sharp,
                  size: iconSize,
                  color: enable ? iconColorEnable : iconColorDisable,
                ),
            SizedBox(
              height: space,
            ),
            Text(text,
                style: textStyle?.copyWith(
                        height: textLineHeight / textSize,
                        fontSize: textSize,
                        fontWeight: FontWeight.w700) ??
                    TextStyle(
                        color: textColor ?? Colors.black,
                        height: textLineHeight / textSize,
                        fontSize: textSize,
                        fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
