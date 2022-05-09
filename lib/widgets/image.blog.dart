import 'package:flutter/material.dart';
import '../utils/helpes/utilities.dart';

class ImageBlogInRow extends StatelessWidget {
  final String? imageUrl;

  ImageBlogInRow({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        return SizedBox(
          height: boxHeight,
          width: boxHeight * 2 / 2,
          child: Utilities.getImageNetwork(imageUrl, fit: BoxFit.cover),
        );
      },
    );
  }
}

class ImageBlogInColumn extends StatelessWidget {
  final String? imageUrl;

  ImageBlogInColumn({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        return SizedBox(
          height: boxWidth * 2 / 3,
          width: boxWidth,
          child: Utilities.getImageNetwork(imageUrl, fit: BoxFit.cover),
        );
      },
    );
  }
}
