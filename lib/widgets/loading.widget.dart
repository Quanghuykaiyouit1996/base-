import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/helpes/utilities.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  LoadingWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        SizedBox(
          child: StreamBuilder<bool>(
              stream: Utilities.streamIsLoading.stream,
              builder: (context, snapshot) {
                if (!(snapshot.data ?? false)) {
                  return Container();
                }

                return GestureDetector(
                    child: Container(
                        width: Get.size.width,
                        height: Get.size.height,
                        color: (snapshot.data ?? false)
                            ? Colors.black.withOpacity(0.2)
                            : null,
                        child: Center(child: CircularProgressIndicator())));
              }),
        ),
      ],
    );
  }
}
