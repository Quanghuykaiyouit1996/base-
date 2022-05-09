import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import 'package:mobile_admin/cored/notification/notification.controller.dart';
import 'package:mobile_admin/utils/icon/custom.icon.dart';
import '../config/pages/app.page.dart';

class IconNotification extends StatelessWidget {
  final NotificationController notificationController =
      Get.find(tag: 'notificationController');
  final AuthController authController = Get.find(tag: 'authController');
  final Function? onClick;
  final Color? iconColor;

  IconNotification({Key? key, this.onClick, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.NOTIFICATION);
        },
        child: Obx(
          () => SizedBox(
            height: 28,
            width: notificationController.totalUnseenCount > 99
                ? 30
                : (notificationController.totalUnseenCount < 10 ? 24 : 26),
            child: Stack(
              alignment: Alignment.bottomLeft,
              clipBehavior: Clip.none,
              children: [
                Icon(
                  MyFlutterApp.ic_notification,
                  color: iconColor,
                  size: 24,
                ),
                Positioned(
                    right: -2,
                    top: 0,
                    child:
                        // notificationController.totalUnseenCount > 0
                        //     ?
                        Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFDB913),
                          borderRadius: BorderRadius.circular(60)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Text(
                        '${notificationController.totalUnseenCount > 99 ? '99+' : notificationController.totalUnseenCount}',
                        style: TextStyle(
                            fontSize: 8,
                            color: Get.theme.primaryColor,
                            height: 1.3,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                    // : const SizedBox()
                    )
              ],
            ),
          ),
        ));
  }
}
