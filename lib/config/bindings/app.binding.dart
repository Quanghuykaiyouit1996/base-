import 'package:get/get.dart';
import 'package:base/app.controller.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/network/network.controller.dart';
import 'package:base/cored/notification/notification.controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), tag: 'authController');
    Get.put<NotificationController>(NotificationController(),
        tag: 'notificationController');
    Get.put<AppController>(AppController());
    Get.put<NetworkController>(NetworkController());
  }
}
