import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/constants/Image.asset.dart';
import 'package:base/utils/icon/custom.icon.dart';

import 'confirmOTP.controller.dart';
import 'confirmOTP.form.dart';

class ConfirmOTPPage extends StatelessWidget {
  final controller = Get.put(ConfirmOTPController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.backgroundColor,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    ImageAsset.backgroundSignup,
                  ))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(MyFlutterApp.left_open,
                                  color: Colors.white)),
                        )),
                  ),
                  Image.asset(
                    ImageAsset.pathLogoWhite,
                    width: 180,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text('Xác nhận OTP',
                      style: Get.textTheme.headline3!
                          .copyWith(color: Colors.white)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      controller.description1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      controller.phoneNumber ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFFFDB913)),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ConfirmOTPForm(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
