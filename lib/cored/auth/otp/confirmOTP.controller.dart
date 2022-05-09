import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/widgets/dialog.widget.dart';

import '../auth.controller.dart';

class ConfirmOTPController extends GetxController {
  TextEditingController? confirmOTPTextController;
  AuthController authController = Get.find(tag: 'authController');
  String? phoneNumber;
  RxInt time = 120.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late String description1;
  String get description2 => '''Vui lòng đợi ${time.value} giây để gửi lại''';

  late Timer _timer;
  @override
  void onInit() {
    confirmOTPTextController = TextEditingController();
    description1 = '''Mã xác minh được gửi qua sms đến''';
    phoneNumber = Get.arguments;
    checkTime();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    confirmOTPTextController!.dispose();
    _timer.cancel();
    super.dispose();
  }

  String? validateOTPText(String value) {
    if (value.isEmpty) {
      return 'Hãy nhập mã OTP';
    } else if (value.length != 6) {
      return 'Mã OTP có đúng 6 chữ số';
    }
    return null;
  }

  void resetOTP() async {
    if (Get.isDialogOpen ?? false) {
      checkTime();
      authController.resetOTP();
    } else {
      Get.rawSnackbar(
        borderRadius: 4.0,
        duration: const Duration(seconds: 1),
        overlayColor: Colors.blue,
        margin: const EdgeInsets.all(16.0),
        messageText: Text('OTP đã được gửi đi, hãy kiên nhẫn chờ đợi',
            style:
                Get.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0x1AE84A4D),
      );
    }
  }

  void confirmOTP() async {
    authController.confirmOtp(confirmOTPTextController!.text);
  }

  void checkTime() {
    const oneSec = Duration(seconds: 1);
    time.value = 120;
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time.value == 0) {
          Get.dialog(
              CustomFailDialog(
                description: 'Thời gian hiệu lực OTP đã hết',
                contentButton: 'Gửi lại OTP',
                function: () {
                  resetOTP();
                  Get.back();
                },
                title: 'Thời gian OTP đã hết',
              ),
              barrierDismissible: false);
          timer.cancel();
        } else {
          time.value--;
        }
      },
    );
  }
}
