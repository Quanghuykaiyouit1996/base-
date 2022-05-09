import 'package:flutter/material.dart';
import '../utils/helpes/utilities.dart';

class ImageProductInRow extends StatelessWidget {
  final String? imageUrl;
  final Widget? onTopImage;

  const ImageProductInRow({this.imageUrl, this.onTopImage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        return SizedBox(
          height: boxHeight,
          width: boxHeight,
          child: Stack(
            children: [
              Utilities.getImageNetwork(imageUrl),
              if (onTopImage != null) onTopImage!
            ],
          ),
        );
      },
    );
  }
}

class ImageProductInColumn extends StatelessWidget {
  final String? imageUrl;
  final Widget? onTopImage;

  const ImageProductInColumn({this.imageUrl, this.onTopImage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        return Stack(
          children: [
            SizedBox(
              height: boxWidth,
              width: boxWidth,
              child: Utilities.getImageNetwork(imageUrl),
            ),
            if (onTopImage != null) onTopImage!
          ],
        );
      },
    );
  }
}
