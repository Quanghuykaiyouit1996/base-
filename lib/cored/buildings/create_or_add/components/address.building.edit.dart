import 'package:get/get.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:flutter/material.dart';
import 'package:base/widgets/button.dropdown.dart';
import 'package:base/widgets/text.form.widget.dart';

import '../building.edit.controller.dart';

class AddressEditBuilding extends StatelessWidget {
  final AddressBaseController controller;
  final controllerBuilding = Get.find<BuildingsAddAndEditController>();

  AddressEditBuilding({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GetBuilder<AddressBaseController>(
          init: controller,
          initState: (_) {},
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    TextFormFieldLogin(
                        hasIcon: false,
                        borderRadiusOut: BorderRadius.circular(4),
                        controller: controller.cityTextController,
                        validator: controller.validateCityAddress),
                    ButtonDropdownAddress(
                      hintText: 'Tỉnh/Thành phố',
                      items: controller.provinces,
                      selectedItem: controller.city,
                      borderRadius: BorderRadius.circular(4),
                      callback: controller.findDistricts,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          TextFormFieldLogin(
                              hasIcon: false,
                              borderRadiusOut: BorderRadius.circular(4),
                              controller: controller.districtTextController,
                              validator: controller.validateDistrictAddress),
                          ButtonDropdownAddress(
                            hintText: 'Quận/Huyện',
                            items: controller.districts,
                            selectedItem: controller.district,
                            borderRadius: BorderRadius.circular(4),
                            callback: controller.findWards,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          TextFormFieldLogin(
                              hasIcon: false,
                              borderRadiusOut: BorderRadius.circular(4),
                              controller: controller.wardTextController,
                              validator: controller.validateWardAddress),
                          ButtonDropdownAddress(
                            hintText: 'Phường/Xã',
                            items: controller.wards,
                            selectedItem: controller.ward,
                            borderRadius: BorderRadius.circular(4),
                            callback: controller.chooseWard,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
      const SizedBox(
        height: 16.0,
      ),
      TextFormFieldLogin(
        controller: controller.addressController,
        validator: controller.validateAddress,
        hintText: 'Địa chỉ thường trú',
      ),
    ]);
  }
}
