import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:flutter/material.dart';
import 'package:base/widgets/dialog.widget.dart';

import 'contract.renewal.provider.dart';

class ContractRenewalController extends GetxController {
  String? contractId;
  final Rx<int> renewalNumber = 0.obs;
  final RxList<int> renewalNumbers = [3, 6, 9, 12].obs;

  final ContractRenewalProvider provider = ContractRenewalProvider();
  final AuthController authController = Get.find(tag: 'authController');

  late TextEditingController noteController;
  late TextEditingController renewalNumberController;

  String? Function(String value) get validateRenewalNumber => (String value) {
        if (value.isEmpty) {
          return 'Hãy chọn thời gian gia hạn';
        }
        return null;
      };
  @override
  void onInit() {
    super.onInit();
    noteController = TextEditingController();
    renewalNumberController = TextEditingController();
    contractId = Get.arguments;
  }

  @override
  void dispose() {
    noteController.dispose();
    renewalNumberController.dispose();
    super.dispose();
  }

  void renewalContract() {
    Get.dialog(CustomChooseDialog(
      acceptFunction: () async {
        var response = await provider.renewelContract(
            contractId, renewalNumber.value, noteController.text);
        if (response.isOk) {
          Get.back();
          Get.dialog(CustomSuccessDialog(
              function: () {
                Get.back();
                Get.until((route) => Get.currentRoute == Routes.INITIAL);
              },
              title: 'Thông báo',
              textButton: 'Trở về trang chủ',
              description: 'Yêu cầu gia hạn thành công'));
        } else {
          Get.back();
          Get.dialog(CustomFailDialog(
              function: () {
                Get.back();
              },
              title: 'Thông báo',
              description:
                  'Yêu cầu gia hạn không thành công \n ${response.body}'));
        }
      },
      closeFunction: () {
        Get.back();
      },
      title: 'Xác nhận',
      description:
          'Bạn muốn yêu cầu gia hạn ? \n Yêu cầu gia hạn chỉ được gửi 1 lần',
    ));
  }
}
