import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/buildings/create_or_add/building.edit.controller.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:base/widgets/image.list.dart';

import '../building.info.controller.dart';

class BuildingInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  BuildingInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        AddressInfo(),
        const SizedBox(
          height: 8,
        ),
        BasicInfo(),
        const SizedBox(
          height: 8,
        ),
        DetailInfo(),
        const SizedBox(
          height: 8,
        ),
        AreaInfo(),
        const SizedBox(
          height: 8,
        ),
        EletricInfo(),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Ảnh tòa nhà',
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 4,
        ),
        ImageList(controller: controller.imageListController, justShow: true)
      ],
    );
  }
}

class AreaInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  AreaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              const Text('Diện tích sàn: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '${controller.areaFloorController.text}m2',
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Row(
            children: [
              const Text('Diện tích tổng: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '${controller.areaAllController.text}m2',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EletricInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  EletricInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Ngày chốt sổ : ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.dateEletricController.text,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Ngày chi tiền điện nước: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.datePayCostController.text,
            ),
          ],
        ),
      ],
    );
  }
}

class BasicInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  BasicInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: 'Tên: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: controller.buildingNameController.text,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ])),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Text('Loại nhà: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.buildingTypeController.text,
            ),
          ],
        ),
      ],
    );
  }
}

class AddressInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  AddressInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressBaseController>(
        init: controller.addressController,
        initState: (_) {},
        builder: (_) {
          return Text.rich(TextSpan(
              text: 'Địa điểm tòa nhà: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: getAddress(
                      controllerAddress: controller.addressController,
                    ),
                    style: const TextStyle(fontWeight: FontWeight.normal)),
              ]));
        });
  }

  String getAddress({required AddressBaseController controllerAddress}) {
    var listTemp = [];
    if (controllerAddress.addressController?.text.isNotEmpty ?? false) {
      listTemp.add(controllerAddress.addressController?.text);
    }
    if (controllerAddress.ward.value.id != null) {
      listTemp.add(controllerAddress.ward.value.name);
    }
    if (controllerAddress.district.value.id != null) {
      listTemp.add(controllerAddress.district.value.name);
    }
    if (controllerAddress.city.value.id != null) {
      listTemp.add(controllerAddress.city.value.name);
    }
    return listTemp.join(',');
  }
}

class DetailInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  DetailInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Số tầng: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    controller.floorTextController.text,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Số phòng: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    controller.roomTextController.text,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
