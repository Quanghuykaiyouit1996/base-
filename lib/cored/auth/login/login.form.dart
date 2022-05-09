import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import '../../../widgets/button.widget.dart';
import '../../../widgets/text.form.widget.dart';

import 'login.controller.dart';

class LoginForm extends GetView {
  @override
  final LoginController controller = Get.find();
  var keyForm = GlobalKey<FormState>();

  LoginForm();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldLogin(
                color: const Color(0xFF454388),
                keyboardType: TextInputType.number,
                hintText: 'Nhập số điện thoại',
                controller: controller.phoneTextController,
                validator: controller.phoneValidate),
            const SizedBox(
              height: 26.0,
            ),
            BigButton(
              function: () {
                if (keyForm.currentState!.validate()) {
                  controller.login();
                }
              },
              text: 'Đăng nhập',
              textColor: Colors.white,
            ),
          ],
        ));
  }
}
