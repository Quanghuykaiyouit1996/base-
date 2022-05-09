import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/utils/icon/custom.icon.dart';

class TitleMainComponanet extends StatelessWidget {
  final String? title;
  final Function? onViewAll;

  final bool hasViewMore;

  const TitleMainComponanet(
      {Key? key, this.title, this.onViewAll, this.hasViewMore = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onViewAll != null) onViewAll!();
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? '',
                  style: Get.textTheme.subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Visibility(
                  visible: hasViewMore,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xem tất cả',
                          style: Get.textTheme.subtitle2!.copyWith(
                              letterSpacing: -0.0024,
                              height: 1.3,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          MyFlutterApp.right_open,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
