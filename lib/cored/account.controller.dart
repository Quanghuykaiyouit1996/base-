import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/dialog.widget.dart';

import 'account.provider.dart';
import 'auth/auth.controller.dart';
import 'menu.account.model.dart';

class AccountController extends GetxController {
  final AuthController authController = Get.find(tag: 'authController');
  final AccountProvider provider = AccountProvider();
  final totalSaleAmount = 0.obs;
  final totalSpendAmount = 0.obs;
  final List<MenuAccount> listMenu = [
    MenuAccount(
        title: 'Phòng của tôi',
        icon: MyFlutterApp.ic_room,
        type: MenuAccountType.MY_ROOM),
    MenuAccount(
        title: 'Đánh giá của tôi',
        icon: MyFlutterApp.ic_rating,
        type: MenuAccountType.MY_REVIEW),
  ];

  Widget getListMenu(int index) {
    return GestureDetector(
      onTap: () {
        changeToScreen(listMenu[index].type);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          children: [
            Icon(
              listMenu[index].icon,
              color: const Color(0xFFFDB913),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              listMenu[index].title ?? '',
              style: Get.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            ))
          ],
        ),
      ),
    );
  }

  void logOut() {
    Get.dialog(CustomChooseDialog(
      acceptFunction: () {
        Get.back();
        authController.removeToken();
      },
      closeFunction: () {
        Get.back();
      },
      title: 'Thông báo',
      description: 'Bạn có chắc muốn đăng xuất?',
      contentAcceptButton: 'Đăng xuất',
    ));
  }

  void changeToScreen(MenuAccountType? type) {
    switch (type) {
      case MenuAccountType.MY_ROOM:
        Get.toNamed(Routes.ROOM);
        break;
      case MenuAccountType.MY_REVIEW:
        Get.toNamed(Routes.MY_REVIEW_ACCOUNT);
        break;

      default:
    }
  }
}
