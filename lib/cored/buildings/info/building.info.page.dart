import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/buildings/create_or_add/components/component.dart';
import 'package:base/cored/buildings/info/components/service.info.dart';
import 'package:base/utils/helpes/constant.dart';

import 'building.info.controller.dart';
import 'components/building.info.dart';
import 'components/description.info.dart';
import 'components/investor.info.dart';
import 'components/roomInfo/room.info.dart';

class BuildingsInfoPage extends StatelessWidget {
  final controller = Get.put(BuildingsInfoController());

  BuildingsInfoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F8FD),
        actions: [
          IconButton(
            icon: Text(controller.buildingId == null ? 'Thêm' : 'Sửa',
                style: const TextStyle(
                  color: Color(0xFF00A79E),
                )),
            onPressed: () {
              Get.toNamed(Routes.EDITANDADDBUILDING,
                  arguments: controller.buildingId);
            },
          )
        ],
        title: Text(
            controller.buildingId == null ? 'Tạo nhà' : 'Sửa thông tin nhà'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<BuildingsInfoController>(
          init: controller,
          initState: (_) {},
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Component(
                  index: 1,
                  title: 'Thông tin chủ đầu tư',
                  widgetChild: InvestorInfo(),
                ),
                Component(
                  index: 2,
                  title: 'Thông tin tòa nhà',
                  widgetChild: BuildingInfo(),
                ),
                Component(
                  index: 3,
                  title: 'Mô tả chi tiết',
                  widgetChild: DescriptionInfo(),
                ),
                Component(
                  index: 4,
                  title: 'Thiết lập phòng',
                  widgetChild: RoomInfo(),
                ),
                Component(
                  index: 5,
                  title: 'Thiết lập dịch vụ',
                  widgetChild: ServiceInfo(
                    title: 'Sửa tiền dịch vụ',
                    list: controller.listServicesTypeService,
                    type: TypeService.service.toShortString(),
                  ),
                ),
                Component(
                  index: 6,
                  title: 'Thiết lập nội quy',
                  widgetChild: ServiceInfo(
                    title: 'Thêm/Sửa nội quy',
                    list: controller.listServicesTypeRule,
                    type: TypeService.rule.toShortString(),
                  ),
                ),
                Component(
                  index: 7,
                  title: 'Thiết lập thiết bị',
                  widgetChild: ServiceInfo(
                    title: 'Thêm/Sửa thiết bị',
                    list: controller.listServicesTypeDevice,
                    type: TypeService.device.toShortString(),
                  ),
                ),
                Component(
                  index: 8,
                  title: 'Thiết lập tài sản',
                  widgetChild: ServiceInfo(
                      title: 'Thêm/Sửa tài sản',
                      list: controller.listServicesTypeFortune,
                      type: TypeService.fortune.toShortString()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
