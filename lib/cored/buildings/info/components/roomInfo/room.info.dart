import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

import 'package:get/get.dart';
import 'package:base/cored/buildings/info/building.info.controller.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';

class RoomInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  RoomInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.building.value.roomCount != null
        ? Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE1E9EC)),
                ),
                child: GetBuilder<BuildingsInfoController>(
                  init: controller,
                  initState: (_) {},
                  id: 'roomInfo',
                  builder: (_) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.rooms.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.only(right: 8),
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFF6F8FB),
                                  image: controller.rooms[index].images == null
                                      ? DecorationImage(
                                          image: NetworkImage(controller
                                              .rooms[index].images![0].source!))
                                      : null,
                                ),
                                child: controller.rooms[index].isTempRoom
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 14,
                                        width: double.infinity,
                                        color: const Color(0XFF00A79E),
                                        child: const Text(
                                          'Phòng mẫu',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Phòng ${controller.rooms[index].name!.replaceAll('P', '')}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0XFF16154E)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${controller.rooms[index].minPrice}đ/tháng',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF9D9BC9)),
                                    ),
                                    Text(
                                      'Diện tích: ${Utilities.checkNullStringHaveUnit(controller.rooms[index].totalArea.toString(), 'm2')}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFF16154E)),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Loại phòng: ${controller.rooms[index].kind}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0XFF16154E)),
                                        ),
                                        Container(
                                          height: 12,
                                          width: 1,
                                          color: const Color(0XFFE1E9EC),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                        ),
                                        Text(
                                          'Số người ở: ${controller.rooms[index].peopleCount}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0XFF16154E)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 65,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        'Tầng ${controller.rooms[index].floor}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0XFF454388))),
                                    Container(
                                      width: 17,
                                      height: 17,
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF00A79E)
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 12,
                                        color: Color(0XFF00A79E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 1,
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE1E9EC)),
                    left: BorderSide(color: Color(0xFFE1E9EC)),
                    right: BorderSide(color: Color(0xFFE1E9EC)),
                  ),
                ),
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
                  Text('Thêm phòng',
                      style: TextStyle(color: Get.theme.primaryColor))
                ]),
              )
            ],
          )
        : Container(
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
              Text('Thêm phòng',
                  style: TextStyle(color: Get.theme.primaryColor))
            ]),
          );
  }
}
