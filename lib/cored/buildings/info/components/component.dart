import 'package:flutter/material.dart';
import 'package:base/utils/icon/custom.icon.dart';

class Component extends StatelessWidget {
  final isShow = ValueNotifier(false);
  final Widget widgetChild;
  final int index;
  final String title;

  Component(
      {Key? key,
      required this.widgetChild,
      required this.index,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<bool>(
          valueListenable: isShow,
          builder: (context, snapshot, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    isShow.value = !isShow.value;
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00A79E),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        child: Text(
                          index.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Color(0xFF00A79E),
                              fontSize: 14,
                              height: 20 / 14),
                        ),
                      ),
                      Icon(
                        snapshot
                            ? MyFlutterApp.down_open
                            : MyFlutterApp.up_open,
                        color: const Color(0xFF00A79E),
                      )
                    ],
                  ),
                ),
                snapshot ? const SizedBox.shrink() : widgetChild,
              ],
            );
          }),
    );
  }
}
