import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helpes/utilities.dart';
import '../../../utils/helpes/validator.dart';

import '../auth.controller.dart';
import 'login.provider.dart';

class LoginController extends GetxController {
  late TextEditingController phoneTextController;
  LoginProvider provider = LoginProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    phoneTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    super.dispose();
  }

  void login() async {
    Utilities.updateLoading(true);
    authController.verify(phoneTextController.text.split(' ').join());
    Utilities.updateLoading(false);
  }

  String? Function(String value) get phoneValidate => (String value) {
        if (value.isEmpty) {
          return 'Số điện thoại là bắt buộc';
        } else if (!Validator.validPhoneNumber(
            value.split(' ').join().trim())) {
          return 'Số điện thoại không hợp lệ';
        }
        return null;
      };
}
