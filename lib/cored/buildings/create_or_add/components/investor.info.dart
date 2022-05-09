import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/buildings/create_or_add/components/required.text.dart';
import 'package:base/widgets/text.form.widget.dart';

import '../building.edit.controller.dart';

class InvestorInfo extends StatelessWidget {
  final controller = Get.find<BuildingsAddAndEditController>();

  InvestorInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const RequiredText(isBold: true, text: 'Tên'),
        const SizedBox(height: 4),
        TextFormFieldLogin(
          controller: controller.nameTextController,
          validator: controller.nameValidator,
        ),
        const SizedBox(height: 16),
        const RequiredText(isBold: true, text: 'Số điện thoại'),
        const SizedBox(height: 4),
        TextFormFieldLogin(
          controller: controller.phoneTextController,
          validator: controller.phoneValidator,
        ),
        const SizedBox(height: 16),
        const RequiredText(isBold: true, text: 'Email'),
        const SizedBox(height: 4),
        TextFormFieldLogin(
          controller: controller.mailTextController,
          validator: controller.mailValidator,
        )
      ],
    );
  }
}
