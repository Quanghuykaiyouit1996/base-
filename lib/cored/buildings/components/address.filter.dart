import 'package:get/get.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:flutter/material.dart';
import 'package:base/widgets/button.dropdown.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/text.form.widget.dart';

import '../building.controller.dart';

class AddressFilterBuilding extends StatelessWidget {
  final AddressBaseController controller;
  final controllerBuilding = Get.find<BuildingController>();
  final Function actionAnimation;

  AddressFilterBuilding(
      {Key? key, required this.controller, required this.actionAnimation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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
                                  validator:
                                      controller.validateDistrictAddress),
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
          SizedBox(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: BigButton(
                    function: () {
                      controllerBuilding.resetAddress();
                      controllerBuilding.updateAddress();
                    },
                    text: 'Xóa bộ lọc',
                    isIconFront: false,
                    textColor: const Color(0xFFEB5757),
                    color: Colors.white,
                    border: const BorderSide(color: Color(0xFFEB5757)),
                    evelation: 0,
                    space: 0,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    padding: EdgeInsets.zero,
                    icon: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: const Color(0xFFEB5757).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                        child: Icon(
                          MyFlutterApp.cancel,
                          color: Color(0xFFEB5757),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BigButton(
                    evelation: 0,
                    function: () async {
                      await controllerBuilding.getBuilding();
                      controllerBuilding.updateAddress();
                      actionAnimation();
                    },
                    text: 'Xác nhận',
                    isIconFront: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
