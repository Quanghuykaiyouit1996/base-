import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.controller.dart';
import 'config/pages/app.page.dart';
import 'cored/account.dart';
import 'cored/auth/auth.controller.dart';
import 'cored/contact/contact.dart';
import 'cored/home/home.controller.dart';
import 'cored/home/home.page.dart';
import 'cored/home/widgets/icon.widget.dart';
import 'cored/network/network.controller.dart';
import 'cored/network/network.error.dart';
import 'utils/helpes/utilities.dart';
import 'utils/icon/custom.icon.dart';

class AppPage extends GetView<AppController> {
  static final AuthController authController = Get.find(tag: 'authController');
  final NetworkController networkController = Get.find();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => networkController.resultNetwork.value.isError
          ? const NetworkErrorPage()
          : Scaffold(
              key: appController.scaffoldKey,
              body: GetBuilder<AppController>(
                init: AppController(),
                id: 'appPageView',
                initState: (_) {},
                builder: (_) {
                  _.pageCurrent = 0;
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: kToolbarHeight * 3 / 2),
                    child: PageView(
                      controller: _.pageController,
                      pageSnapping: false,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [HomePage(), ContactPage(), AccountPage()],
                    ),
                  );
                },
              ),
              bottomSheet: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)),
                height: kToolbarHeight * 3 / 2,
                width: Get.size.width,
                child: GetBuilder<AppController>(
                  init: AppController(),
                  id: 'bottomBar',
                  initState: (_) {},
                  builder: (_) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomIcon(
                            icon: MyFlutterApp.ic_home,
                            textColor: _.pageCurrent == 0
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            iconColorEnable: _.pageCurrent == 0
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            text: 'Trang chủ',
                            function: () {
                              if (_.pageCurrent != 0) {
                                controller.navigateToPage(0);
                              }
                              try {
                                var homeController = Get.find<HomeController>();
                                homeController.getBills();
                              } catch (e) {
                                e.printError();
                              }
                            },
                            textSize: 11,
                            iconSize: 24,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomIcon(
                            icon: MyFlutterApp.ic_phone,
                            textColor: _.pageCurrent == 1
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            iconColorEnable: _.pageCurrent == 1
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            text: 'Liên hệ',
                            textSize: 11,
                            function: () {
                              if (_.pageCurrent != 1) {
                                controller.navigateToPage(1);
                              }
                            },
                            iconSize: 24,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomIcon(
                            icon: MyFlutterApp.ic_profile,
                            textColor: _.pageCurrent == 2
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            iconColorEnable: _.pageCurrent == 2
                                ? Get.theme.primaryColorDark
                                : Colors.grey,
                            text: 'Tài khoản',
                            textSize: 11,
                            function: () {
                              if (_.pageCurrent != 2) {
                                controller.navigateToPage(2);
                              }
                              if (authController.hasToken.value) {
                                authController.getUserInfo();
                              }
                            },
                            iconSize: 24,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
