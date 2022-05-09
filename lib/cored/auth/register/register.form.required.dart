import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/pages/app.page.dart';
import '../../../widgets/button.widget.dart';
import '../../../widgets/text.form.widget.dart';
import 'register.controller.dart';

class RegisterForm extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();

   RegisterForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: 'Tên cửa hàng',
                    style: Get.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: const [
               TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
            const SizedBox(
              height: 16.0,
            ),
            TextFormFieldLogin(
                hasPrefixIcon: true,
                // prefixIcon: BaoNgocIcon.ic_store,
                hintText: 'Nhập tên cửa hàng của bạn',
                controller: controller.nameStoreTextController,
                validator: controller.validateStore),
            const SizedBox(
              height: 16.0,
            ),
            RichText(
                text: TextSpan(
                    text: 'Nhập số điện thoại',
                    style: Get.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
            const SizedBox(
              height: 16.0,
            ),
            TextFormFieldLogin(
                keyboardType: TextInputType.number,
                hasPrefixIcon: true,
                hintText: 'Nhập số điện thoại của bạn',
                controller: controller.phoneNumberTextController,
                validator: controller.validatePhoneNumber),
            const SizedBox(
              height: 16.0,
            ),
            BigButton(
              function: () {
                if (controller.key.currentState!.validate()) {
                  Get.toNamed(Routes.REGISTERNONREQUIRED);
                }
              },
              text: 'Tiếp tục',
            )
          ],
        ));
  }
}
