import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/button.dropdown.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/component.dart';
import 'package:base/widgets/text.form.widget.dart';

import 'contract.renewal.controller.dart';

class ContractRenewalPage extends StatelessWidget {
  final controller = Get.put(ContractRenewalController());

  ContractRenewalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gia hạn hợp đồng'),
          titleSpacing: 0,
        ),
        backgroundColor: Color(0xFFF5F8FD),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE1E9EC)))),
            child: BigButton(
              function: () {
                controller.renewalContract();
              },
              text: 'Xác nhận',
            )),
        body: SingleChildScrollView(
          child: GetBuilder<ContractRenewalController>(
              initState: (_) {},
              builder: (_) {
                return Column(
                  children: [
                    Component(
                      widgetChild: MonthRenewal(),
                      index: 1,
                      hasHide: false,
                      title: 'Số tháng gia hạn',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: NoteInfo(),
                      index: 2,
                      hasHide: false,
                      title: 'Ghi chú',
                    ),
                  ],
                );
              }),
        ));
  }
}

class MonthRenewal extends StatelessWidget {
  final controller = Get.find<ContractRenewalController>();

  MonthRenewal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Stack(
        children: [
          TextFormFieldLogin(
              controller: controller.renewalNumberController,
              validator: controller.validateRenewalNumber),
          Obx(() => controller.renewalNumbers.isEmpty
              ? Container()
              : ButtonDropdown<int>(
                  items: controller.renewalNumbers,
                  callback: (value) {
                    controller.renewalNumberController.text = value.toString();
                  },
                  hintText: 'Chọn số tháng gia hạn *',
                  selectedItem: controller.renewalNumber,
                  childs: controller.renewalNumbers.map((item) {
                    return DropdownMenuItem<int>(
                      value: item,
                      child: Text('Gia hạn $item tháng'),
                    );
                  }).toList(),
                )),
        ],
      ),
    );
  }
}

class NoteInfo extends StatelessWidget {
  final controller = Get.find<ContractRenewalController>();

  NoteInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormFieldLogin(
        controller: controller.noteController,
        hintText: 'Nhập ghi chú',
        maxLines: 3,
      ),
    );
  }
}
