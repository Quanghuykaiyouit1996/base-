import 'package:flutter/material.dart';

class MultiClickDisable extends StatefulWidget {
  final Widget child;

  MultiClickDisable({Key? key, required this.child}) : super(key: key);

  @override
  _MultiClickDisableState createState() => _MultiClickDisableState();
}

class _MultiClickDisableState extends State<MultiClickDisable> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: GestureDetector(
              onTap: () {
                if (!isClick) {}
              },
              child: Container()),
        )
      ],
    );
  }
}
