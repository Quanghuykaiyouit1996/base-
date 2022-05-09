import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import '../config/pages/app.page.dart';

class CheckLogin extends StatelessWidget {
  final Widget child;
  CheckLogin({Key? key, required this.child}) : super(key: key);
  final AuthController authController = Get.find(tag: 'authController');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.WELCOME);
          },
          child: Obx(() => !authController.hasToken.value
              ? Container(
                  color: Colors.white.withOpacity(0.01),
                )
              : Container()),
        ))
      ],
    );
  }
}
