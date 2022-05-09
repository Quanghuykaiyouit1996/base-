import 'package:card_swiper/card_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/building.model.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/component.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.branch.dart';
import 'package:base/widgets/image.product.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'room.detail.controller.dart';

class RoomDetailPage extends StatelessWidget {
  RoomDetailPage({Key? key}) : super(key: key);

  final controller = Get.put(RoomDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết phòng'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<RoomDetailController>(
              initState: (_) {},
              builder: (_) {
                return Column(
                  children: [
                    BaseInfo(),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: ServiceInfo(),
                      index: 1,
                      title: 'Dịch vụ',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild:
                          AnotherServiceInfo(type: TypeService.fortune),
                      index: 2,
                      title: 'Tài sản',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: AnotherServiceInfo(type: TypeService.device),
                      index: 3,
                      title: 'Tiện ích',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: AnotherServiceInfo(type: TypeService.rule),
                      index: 4,
                      title: 'Nội quy',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: ContractInfo(),
                      index: 5,
                      title: 'Hợp đồng',
                    ),
                  ],
                );
              }),
        ));
  }
}

class ContractInfo extends StatelessWidget {
  final controller = Get.find<RoomDetailController>();

  ContractInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AnotherServiceInfo extends StatelessWidget {
  final controller = Get.find<RoomDetailController>();
  final TypeService type;
  AnotherServiceInfo({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listService = <Services>[];
    switch (type) {
      case TypeService.fortune:
        listService.addAll(controller.room.value.fortuneList);
        break;
      case TypeService.rule:
        listService.addAll(controller.room.value.ruleList);
        break;
      case TypeService.device:
        listService.addAll(controller.room.value.deviceList);
        break;
      case TypeService.all:
        break;
      case TypeService.service:
        break;
    }
    return CustomList(
      mainAxisCount: 2,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 16),
      backgroundColor: Colors.transparent,
      mainSpace: 8,
      customWidget: (index) {
        return Row(
          children: [
            SizedBox(
                height: 30,
                width: 30,
                child: Utilities.getImageNetwork(listService[index].image)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                listService[index].name,
                style: const TextStyle(color: Color(0xFF9D9BC9)),
              ),
            )
          ],
        );
      },
      itemCount: listService.length,
    );
  }
}

class ServiceInfo extends StatelessWidget {
  final controller = Get.find<RoomDetailController>();

  ServiceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listService = controller.room.value.serviceList;
    return CustomList(
      mainAxisCount: 1,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 16),
      backgroundColor: Colors.transparent,
      mainSpace: 8,
      customWidget: (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                  text: listService[index].name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: ' (${listService[index].unit})',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  ]),
            ),
            Text(
              Convert.convertMoney(listService[index].minPrice),
              style: const TextStyle(color: Color(0xFF9D9BC9)),
            )
          ],
        );
      },
      itemCount: listService.length,
    );
  }
}

class BaseInfo extends StatelessWidget {
  final controller = Get.find<RoomDetailController>();

  BaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var room = controller.room.value;
    var swiperController = SwiperController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (controller.room.value.images?.isEmpty ?? true)
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  SizedBox(
                    height: 250,
                    child: MySlider(
                      child: (index) {
                        return ImageBranchInColumn(
                            imageUrl:
                                controller.room.value.images![index].source);
                      },
                      scrollDirection: Axis.horizontal,
                      onClickItem: (index) {
                        Utilities.showImage(
                            controller.room.value.images![index].source);
                      },
                      itemCount: controller.room.value.images?.length ?? 0,
                      controller: swiperController,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                swiperController.previous();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ColoredBox(
                                    color: Colors.white.withOpacity(0.7),
                                    child: const Icon(MyFlutterApp.left_open)),
                              )),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                swiperController.next();
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: ColoredBox(
                                      color: Colors.white.withOpacity(0.7),
                                      child:
                                          const Icon(MyFlutterApp.right_open))))
                        ],
                      ),
                    ),
                  )
                ],
              ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room.name ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                    text: 'Tòa nhà: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: controller.building?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                    text: 'Địa chỉ: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Utilities.getAddress(
                            controller.building?.address ?? AddressModel()),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                    text: 'Loại phòng: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: room.type,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          text: 'Tầng: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: room.floor?.toString() ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          text: 'Số người phù hợp: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: room.peopleCount?.toString() ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                    text: 'Diện tích: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Utilities.stringHasSuffix(
                            room.floorArea.toString(), ' m2'),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                    text: 'Giá: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Utilities.stringHasSuffix(
                            Convert.convertMoney(room.minPrice), '/tháng'),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MySlider extends StatelessWidget {
  final int? itemCount;
  final SwiperController controller;
  final Axis? scrollDirection;
  final Widget Function(int index) child;
  final Function(int index)? onClickItem;
  final SwiperPagination? pagination;

  const MySlider(
      {this.itemCount,
      this.scrollDirection,
      required this.child,
      this.onClickItem,
      required this.controller,
      this.pagination});
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: itemCount ?? 1,
      controller: controller,
      loop: true,
      onIndexChanged: (index) {
        print(index);
      },
      scrollDirection: scrollDirection!,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              if (onClickItem != null) {
                onClickItem!(index);
              }
            },
            child: child(index));
      },
      pagination: pagination,
    );
  }
}
