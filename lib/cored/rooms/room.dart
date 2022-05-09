import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.product.dart';

import 'room.controller.dart';

class RoomPage extends StatelessWidget {
  final controller = Get.put(RoomController());

  RoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phòng của tôi'),
          titleSpacing: 0,
          elevation: 1,
        ),
        backgroundColor: Color(0xFFF5F8FD),
        body: Obx(() => RefreshIndicator(
              onRefresh: () async {
                controller.getRooms();
              },
              child: CustomList(
                scrollDirection: Axis.vertical,
                mainAxisCount: 1,
                borderRadius: 6,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shrinkWrap: false,
                scrollPhysics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                mainSpace: 10,
                crossSpace: 10,
                onClickItem: (index) {
                  Get.toNamed(Routes.ROOMDETAIL, arguments: [
                    controller.rooms[index].id,
                    controller.rooms[index].building
                  ]);
                },
                itemCount: controller.rooms.length,
                customWidget: (index) =>
                    InfoRoom(room: controller.rooms[index]),
              ),
            )));
  }
}

class InfoRoom extends StatelessWidget {
  final Room room;

  const InfoRoom({
    Key? key,
    required this.room,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: ImageProductInRow(
              imageUrl: room.image,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(room.name ?? ''),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  room.building?.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  Utilities.getAddress(
                      room.building?.address ?? AddressModel()),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Icon(MyFlutterApp.right_open)
        ],
      ),
    );
  }
}
