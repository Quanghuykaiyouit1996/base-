import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/utils/helpes/utilities.dart';
import '../constants/Image.asset.dart';

class EmptyScreen extends StatelessWidget {
  final String? imageAsset;
  final String? content;

  const EmptyScreen({Key? key, this.imageAsset, this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Utilities.streamIsLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? true) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imageAsset ?? ImageAsset.pathPlaceHolder),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  content ?? '',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: const Color(0xFFAAB1C5)),
                )
              ],
            ),
          );
        });
  }
}
