import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:base/cored/buildings/create_or_add/building.edit.controller.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/text.form.widget.dart';

import '../building.info.controller.dart';

class DescriptionInfo extends StatelessWidget {
  DescriptionInfo({Key? key}) : super(key: key);
  final controllerBuilding = Get.find<BuildingsInfoController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => controllerBuilding.description.value.trim().isEmpty
              ? Row(children: [
                  GestureDetector(
                    onTap: () {
                      controllerBuilding.openEditor(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Get.theme.primaryColor.withOpacity(0.4)),
                      child: Icon(MyFlutterApp.plus,
                          color: Get.theme.primaryColor, size: 14),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text('Thêm mô tả chi tiết',
                      style: TextStyle(color: Get.theme.primaryColor))
                ])
              : Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE1E9EC))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    controllerBuilding.htmlToString,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0XFF454388),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAllDescription(
                                        controllerBuilding.description.value);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Xem thêm',
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToLastDescent: true),
                                        style: TextStyle(
                                            color: Color(0xFF00A79E))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Tag',
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 4,
          ),
          ListTag()
        ],
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text ?? '').documentElement?.text ?? '';

    return parsedString;
  }

  void showAllDescription(String value) {
    Get.dialog(Material(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: value
                    .split('****')
                    .firstWhere((element) => true, orElse: () => ''),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SmallButton(
            function: () {
              Get.back();
            },
            iconSize: const Size(100, 40),
            text: 'Đóng',
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

class ListTag extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  ListTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Wrap(
            spacing: 4,
            runSpacing: 4,
            children: controller.listTag
                .map((element) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE1E9EC)),
                        color: const Color(0xFFEBFFF8)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          element,
                          style: const TextStyle(color: Color(0xFF00A79E)),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            controller.listTag.remove(element);
                          },
                          child: const Icon(
                            MyFlutterApp.cancel,
                            color: Colors.red,
                            size: 16,
                          ),
                        )
                      ],
                    )))
                .toList()))
      ],
    );
  }
}
