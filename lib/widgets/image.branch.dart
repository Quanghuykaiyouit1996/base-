import 'package:flutter/material.dart';
import '../utils/helpes/utilities.dart';

class ImageBranchInRow extends StatelessWidget {
  final String? imageUrl;

  ImageBranchInRow({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        return SizedBox(
          height: boxHeight,
          width: boxHeight * 3 / 2,
          child: Utilities.getImageNetwork(imageUrl),
        );
      },
    );
  }
}

class ImageBranchInColumn extends StatelessWidget {
  final String? imageUrl;
  final double? ratio;

  ImageBranchInColumn({this.imageUrl, this.ratio});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        return SizedBox(
          height: boxWidth * (ratio ?? (2 / 3)),
          width: boxWidth,
          child: Utilities.getImageNetwork(imageUrl),
        );
      },
    );
  }
}
