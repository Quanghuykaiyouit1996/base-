import 'package:flutter/material.dart';
import 'package:mobile_admin/utils/icon/custom.icon.dart';

class Component extends StatelessWidget {
  final isShow = ValueNotifier(false);
  final Widget widgetChild;
  final int index;
  final bool hasHide;
  final String title;

  Component(
      {Key? key,
      required this.widgetChild,
      required this.index,
      required this.title,
      this.hasHide = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE1E9EC)))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<bool>(
            valueListenable: isShow,
            builder: (context, snapshot, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (hasHide) {
                        isShow.value = !isShow.value;
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFDB913),
                              borderRadius: BorderRadius.circular(4)),
                          alignment: Alignment.center,
                          child: Text(
                            index.toString(),
                            style: const TextStyle(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style:
                                const TextStyle(fontSize: 14, height: 20 / 14),
                          ),
                        ),
                        hasHide
                            ? Icon(
                                snapshot
                                    ? MyFlutterApp.down_open
                                    : MyFlutterApp.up_open,
                                size: 28,
                                color: Colors.black,
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  hasHide
                      ? (snapshot ? const SizedBox.shrink() : widgetChild)
                      : widgetChild,
                ],
              );
            }),
      ),
    );
  }
}
