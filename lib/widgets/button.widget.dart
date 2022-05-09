import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BigButton extends StatefulWidget {
  final Function function;
  final String text;
  final Color? color;
  final Color textColor;
  final Color? splashColor;
  final double fontSize;
  final Widget? icon;
  final bool isIconFront;
  final BorderSide? border;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? space;
  final double? evelation;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;

  const BigButton({
    required this.function,
    required this.text,
    this.splashColor,
    this.fontSize = 15,
    this.color,
    this.textColor = Colors.white,
    this.icon,
    this.space,
    this.borderRadius,
    this.isIconFront = false,
    this.padding,
    this.border,
    this.margin,
    this.evelation,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  _BigButtonState createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  bool isClickButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.margin,
      constraints: const BoxConstraints.tightFor(height: 40),
      child: ButtonTheme(
        height: 0,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(4.0),
          side: widget.border ?? BorderSide.none,
        ),
        splashColor: widget.splashColor ?? Get.theme.primaryColorLight,
        buttonColor: widget.color ?? Get.theme.primaryColor,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: widget.evelation,
              primary: widget.color ?? Get.theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(4.0),
                side: widget.border ?? BorderSide.none,
              )),
          onPressed: () {
            if (!isClickButton) {
              isClickButton = true;
              widget.function();
              Future.delayed(const Duration(seconds: 1), () {
                isClickButton = false;
              });
            }
          },
          child: Padding(
            padding:
                widget.padding ?? const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: widget.mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.isIconFront) (widget.icon ?? const SizedBox()),
                if (widget.isIconFront)
                  SizedBox(
                    width: widget.isIconFront ? (widget.space ?? 0) : 0,
                  ),
                Text(
                  widget.text,
                  style: TextStyle(
                      letterSpacing: -0.0024,
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      height: 1.3,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: !widget.isIconFront ? (widget.space ?? 0) : 0,
                ),
                !widget.isIconFront
                    ? (widget.icon ?? Container())
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatefulWidget {
  final Function function;
  final String? text;
  final Color? color;
  final Color textColor;
  final Color? splashColor;
  final double fontSize;
  final EdgeInsets padding;
  final IconData? icon;
  final Size iconSize;
  final bool isClickMulti;
  final BorderRadius? borderRadius;
  final Widget? widget;
  final BorderSide? border;
  final List<BoxShadow>? boxShadow;

  const SmallButton({
    required this.function,
    this.text,
    this.splashColor,
    this.fontSize = 15,
    this.color,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.icon,
    this.widget,
    this.iconSize = const Size(20, 20),
    this.isClickMulti = true,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  _SmallButtonState createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  bool isClickButton = false;
  Color getColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return widget.color ?? Get.theme.primaryColor;
    }
    if (states.any((element) => element == MaterialState.pressed)) {
      return widget.splashColor ?? Get.theme.primaryColorLight;
    }
    return widget.color ?? Get.theme.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.isClickMulti) {
          if (!isClickButton) {
            isClickButton = true;
            widget.function();
            Future.delayed(const Duration(seconds: 1), () {
              isClickButton = false;
            });
          }
        } else {
          widget.function();
        }
      },
      child: Padding(
        padding: widget.padding,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.color ?? Get.theme.primaryColorLight,
              boxShadow: widget.boxShadow,
              border: Border.fromBorderSide(
                  widget.border ?? const BorderSide(color: Colors.transparent)),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4)),
          constraints: BoxConstraints(
            minHeight: widget.iconSize.height,
            minWidth: widget.iconSize.width,
            maxHeight: widget.iconSize.height,
            maxWidth: widget.iconSize.width,
          ),
          child: widget.widget ??
              (widget.icon == null
                  ? Text(
                      widget.text!,
                      style: TextStyle(
                          letterSpacing: -0.0024,
                          color: widget.textColor,
                          fontSize: widget.fontSize,
                          height: 1.3,
                          fontWeight: FontWeight.w500),
                    )
                  : Icon(
                      widget.icon,
                      color: widget.textColor,
                      size: widget.fontSize,
                    )),
        ),
      ),
      // style: TextButton.styleFrom(
      //     tapTargetSize: MaterialTapTargetSize.padded,
      //     minimumSize: Size(10, 0),
      //     backgroundColor: color,
      //     padding: padding),
      // onPressed: function as void Function()?,
    );
  }
}
