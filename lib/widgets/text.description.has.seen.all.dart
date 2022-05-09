import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasSeenAllText extends StatelessWidget {
  final String? text;
  final TextStyle? texStyle;
  final int? maxLines;
  final RxBool isFull = false.obs;

  HasSeenAllText({Key? key, this.text, this.texStyle, this.maxLines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contrants) {
      return Container(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isFull.value
                    ? Text(
                        text ?? '',
                        style: texStyle,
                        maxLines: maxLines,
                      )
                    : Text(
                        text ?? '',
                        style: texStyle,
                      ),
                SizedBox(
                  height: 8,
                ),
                !isFull.value
                    ? (hasTextOverflow(
                            text ?? '',
                            texStyle ??
                                Get.textTheme.bodyText2!
                                    .copyWith(fontWeight: FontWeight.w400),
                            maxLines: 2,
                            maxWidth: contrants.constrainWidth())
                        ? GestureDetector(
                            onTap: () {
                              isFull.value = true;
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              'Xem thêm',
                              style: Get.textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Get.theme.primaryColor),
                            ),
                          )
                        : Container())
                    : GestureDetector(
                        onTap: () {
                          isFull.value = false;
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          'Thu gọn',
                          style: Get.textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Get.theme.primaryColor),
                        ),
                      ),
              ],
            )),
      );
    });
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
