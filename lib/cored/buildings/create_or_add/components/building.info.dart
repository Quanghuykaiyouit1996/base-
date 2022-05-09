import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/buildings/create_or_add/building.edit.controller.dart';
import 'package:base/cored/buildings/create_or_add/components/required.text.dart';
import 'package:base/models/building.model.dart';
import 'package:base/widgets/button.dropdown.dart';
import 'package:base/widgets/image.list.dart';
import 'package:base/widgets/text.form.widget.dart';

import 'address.building.edit.dart';

class BuildingInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

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
          'Thêm ảnh',
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 4,
        ),
        ImageList(controller: controller.imageListController)
      ],
    );
  }
}

class AreaInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

  AreaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Diện tích sàn',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormFieldUnit(
                controller: controller.areaFloorController,
                validator: controller.areaFloorValidator,
                unit: 'm2',
              )
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Diện tích tổng',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormFieldUnit(
                controller: controller.areaAllController,
                validator: controller.areaValidator,
                unit: 'm2',
              )
            ],
          ),
        ),
      ],
    );
  }
}

class EletricInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

  EletricInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ngày chốt sổ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormFieldLogin(
                controller: controller.dateEletricController,
                validator: controller.dateValidatorController,
              )
            ],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ngày chi điện nước',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormFieldLogin(
                controller: controller.datePayCostController,
                validator: controller.paymentValidator,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BasicInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

  BasicInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RequiredText(isBold: true, text: 'Tên'),
        const SizedBox(height: 4),
        TextFormFieldLogin(
            controller: controller.buildingNameController,
            validator: controller.buildingNameValidator),
        const SizedBox(
          height: 8,
        ),
        const RequiredText(isBold: true, text: 'Chọn loại nhà'),
        const SizedBox(height: 4),
        Stack(
          children: [
            TextFormFieldLogin(
                controller: controller.buildingTypeController,
                validator: controller.validateBuildingType),
            Obx(() => controller.buildingTypes.isEmpty
                ? Container()
                : ButtonDropdown<BuildingType>(
                    items: controller.buildingTypes,
                    callback: (value) {
                      controller.buildingTypeController.text = value.name ?? '';
                    },
                    hintText: 'Loại nhà',
                    selectedItem: controller.buildingType,
                    childs: controller.buildingTypes.map((item) {
                      return DropdownMenuItem<BuildingType>(
                        value: item,
                        child: Text(item.name ?? ''),
                      );
                    }).toList(),
                  )),
          ],
        ),
      ],
    );
  }
}

class AddressInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

  AddressInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RequiredText(isBold: true, text: 'Địa chỉ tòa nhà'),
        const SizedBox(height: 4),
        AddressEditBuilding(
          controller: controller.addressController,
        ),
      ],
    );
  }
}

class DetailInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

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
              const RequiredText(isBold: true, text: 'Số tầng'),
              const SizedBox(height: 4),
              TextFormFieldLogin(
                controller: controller.floorTextController,
                validator: controller.floorValidator,
              )
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
              const RequiredText(isBold: true, text: 'Số phòng'),
              const SizedBox(height: 4),
              TextFormFieldLogin(
                controller: controller.roomTextController,
                validator: controller.roomValidator,
              )
            ],
          ),
        ),
      ],
    );
  }
}
