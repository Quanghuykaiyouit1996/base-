import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../utils/helpes/validator.dart';

import '../auth.controller.dart';
import 'register.provider.dart';

class RegisterController extends GetxController {
  TextEditingController? phoneNumberTextController;
  TextEditingController? nameStoreTextController;
  TextEditingController? addressTextController;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormState> keyNonRequired = GlobalKey<FormState>();

  bool? privacyAccept = false;
  final String description1 = 'Lorem ipsum dolor sit amet, consectetur';
  final String description2 =
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua';
  final provider = RegisterProvider();
  final RxList<String> image = <String>[].obs;
  final RxList<File> imageFile = <File>[].obs;


  final authController = Get.find<AuthController>(tag: 'authController');

  String? Function(String value) get validateDistributor => (String value) {
        if (value.isEmpty) {
          return 'Hãy chọn một nhà phân phối';
        }
        return null;
      };

  TextEditingController? distributorTextController;

  @override
  void onInit() {
    phoneNumberTextController = TextEditingController();
    distributorTextController = TextEditingController();
    nameStoreTextController = TextEditingController();
    addressTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumberTextController?.dispose();
    addressTextController?.dispose();
    nameStoreTextController?.dispose();
    phoneNumberTextController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void register() {
    provider.regiter(
      phoneNumber: phoneNumberTextController!.text.split(' ').join(),
    );
  }

  String? Function(String value) get validatePhoneNumber => (String value) {
        if (value.isEmpty) {
          return 'Số điện thoại là bắt buộc';
        } else if (!Validator.validPhoneNumber(
            value.split(' ').join().trim())) {
          return 'Số điện thoại không hợp lệ';
        }
        return null;
      };

  String? Function(String value) get validateStore => (String value) {
        if (value.isEmpty) {
          return 'Tên cửa hàng là bắt buộc';
        }
        return null;
      };

  void changePrivacyCheckBox(bool? value) {
    privacyAccept = value;
    update(['privacyAccept']);
  }

 
}
