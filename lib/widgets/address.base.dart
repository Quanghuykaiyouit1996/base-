import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/widgets/text.form.widget.dart';

import 'address.base.controller.dart';
import 'button.dropdown.dart';

class GetAddressBase extends StatelessWidget {
  final AddressBaseController controller;

  const GetAddressBase({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressBaseController>(
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
                      controller: controller.cityTextController,
                      validator: controller.validateCityAddress),
                  ButtonDropdownAddress(
                    hintText: 'Tỉnh/Thành phố',
                    items: controller.provinces,
                    selectedItem: controller.city,
                    callback: controller.findDistricts,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Stack(
                children: [
                  TextFormFieldLogin(
                      hasIcon: false,
                      controller: controller.districtTextController,
                      validator: controller.validateDistrictAddress),
                  ButtonDropdownAddress(
                    hintText: 'Quận/Huyện',
                    items: controller.districts,
                    selectedItem: controller.district,
                    callback: controller.findWards,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Stack(
                children: [
                  TextFormFieldLogin(
                      hasIcon: false,
                      controller: controller.wardTextController,
                      validator: controller.validateWardAddress),
                  ButtonDropdownAddress(
                    hintText: 'Phường/Xã',
                    items: controller.wards,
                    selectedItem: controller.ward,
                    callback: controller.chooseWard,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormFieldLogin(
                controller: controller.addressController,
                validator: controller.validateAddress,
                hintText: 'Địa chỉ thường trú',
              ),
            ],
          );
        });
  }
}


