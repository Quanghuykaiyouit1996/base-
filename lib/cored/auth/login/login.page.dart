import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/constants/Image.asset.dart';
import '../../../config/pages/app.page.dart';

import 'login.controller.dart';
import 'login.form.dart';

class LoginPage extends GetView<LoginController> {
  @override
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: Get.currentRoute == Routes.INITIAL
        //     ? AppBar(
        //         centerTitle: true,
        //         shadowColor: Get.currentRoute == Routes.INITIAL
        //             ? null
        //             : Colors.transparent,
        //         leading: Visibility(
        //           visible: Get.currentRoute != Routes.INITIAL,
        //           child: IconButton(
        //             icon: Icon(Icons.arrow_back),
        //             onPressed: () {
        //               Get.back();
        //             },
        //           ),
        //         ),
        //         title: Text(
        //           Get.currentRoute == Routes.INITIAL ? 'Đăng nhập' : '',
        //           style: Get.textTheme.headline2,
        //         ),
        //         backgroundColor: Get.currentRoute == Routes.INITIAL
        //             ? Colors.white
        //             : Get.theme.backgroundColor,
        //       )
        //     : null,
        backgroundColor: Get.theme.backgroundColor,
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(top: kToolbarHeight + 24),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    ImageAsset.backgroundSignup,
                  ))),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  Image.asset(
                    ImageAsset.pathLogoWhite,
                    width: 180,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ));
  }
}
