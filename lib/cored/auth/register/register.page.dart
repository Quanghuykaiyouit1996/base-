import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/constants/Image.asset.dart';
import '../../../utils/custom.icon.dart';
import 'register.controller.dart';

import 'register.form.required.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: Get.currentRoute == Routes.INITIAL
        //       ? null
        //       : GestureDetector(
        //           behavior: HitTestBehavior.translucent,
        //           onTap: () {
        //             Get.back();
        //           },
        //           child: Icon(IconCustom.icon_back)),
        //   backgroundColor: Get.theme.backgroundColor,
        //   shadowColor: Colors.transparent,
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 5),
              child: Icon(
                IconCustom.icon_back,
                color: Colors.white,
              ),
            )),
        backgroundColor: Get.theme.backgroundColor,
        body: Container(
          padding: const EdgeInsets.only(top: kToolbarHeight + 24),
          height: Get.size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageAsset.pathBackGroundLogin,
                ),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  ImageAsset.pathLogoWhite,
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Đăng ký',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white)),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF66677A).withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
                      child: RegisterForm(),
                    )),
                const SizedBox(
                  height: 16.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Đăng nhập',
                      style: Get.textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' nếu bạn đã có tài khoản',
                          style: Get.textTheme.bodyText2!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }
}
