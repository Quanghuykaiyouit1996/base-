import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/buildings/info/building.info.controller.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/icon/custom.icon.dart';

class ServiceInfo extends StatelessWidget {
  ServiceInfo(
      {Key? key, required this.title, required this.list, required this.type})
      : super(key: key);

  final String title;
  final List<Services> list;
  final String type;

  final controller = Get.find<BuildingsInfoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: list.isEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    // controllerBuilding.openEditor(context);
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
                Text('Thêm ${type.toLowerCase()}',
                    style: TextStyle(color: Get.theme.primaryColor))
              ]),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                ServiceListView(list: list, type: type),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: const Color(0XFF00A79E).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Icon(
                        Icons.edit,
                        size: 12,
                        color: Color(0XFF00A79E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xFF00A79E),
                            fontSize: 14,
                            height: 20 / 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

class ServiceListView extends StatelessWidget {
  const ServiceListView({
    Key? key,
    required this.list,
    required this.type,
  }) : super(key: key);

  final List<Services> list;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              list.length.isOdd ? list.length ~/ 2 + 1 : list.length ~/ 2,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              // height: 20,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ServiceListViewRowItem(
                      list: list,
                      type: type,
                      index: index,
                      position: 0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  index == list.length ~/ 2
                      ? const Expanded(child: SizedBox())
                      : Expanded(
                          child: ServiceListViewRowItem(
                              list: list,
                              type: type,
                              index: index,
                              position: 1),
                        )
                ],
              ),
            );
          },
        ));
  }
}

class ServiceListViewRowItem extends StatelessWidget {
  const ServiceListViewRowItem({
    Key? key,
    required this.list,
    required this.type,
    required this.index,
    required this.position,
  }) : super(key: key);

  final List<Services> list;
  final String type;
  final int index;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: list[2 * index + position].images == null ||
                  list[2 * index + position].images!.isEmpty
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: FittedBox(
                    child: Image.asset('assets/images/service_empty.png'),
                  ),
                )
              : Image.network(list[2 * index + position].images![0].source!),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Text(
            type == TypeService.service.toShortString()
                ? '${list[2 * index + position].name} (${list[2 * index + position].unit})'
                : list[2 * index + position].name,
            style: const TextStyle(
                color: Color(0xFF16154E), fontSize: 14, height: 20 / 16),
          ),
        ),
      ],
    );
  }
}
