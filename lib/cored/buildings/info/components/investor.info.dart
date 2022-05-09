import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';

import '../building.info.controller.dart';


class InvestorInfo extends StatelessWidget {
  final controller = Get.find<BuildingsInfoController>();

  InvestorInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Tên: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.nameTextController.text,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Số điện thoại: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.phoneTextController.text,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Email: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              controller.mailTextController.text,
            ),
          ],
        ),
      ],
    );
  }
}
