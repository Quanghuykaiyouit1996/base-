import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  final String text;
  final bool isBold;

  const RequiredText({Key? key, required this.text, this.isBold = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        children: [
          TextSpan(
              text: ' *',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400))
        ],
        text: text,
        style:
            TextStyle(fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)));
  }
}
