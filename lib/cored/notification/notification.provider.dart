import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/notification/notification.controller.dart';
import 'package:base/models/notification.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class NotificationProvider extends MyConnect {
  NotificationProvider();

  AuthController authController = Get.find(tag: 'authController');

  getNotification(TypeListNotification value, {int? skip, int? take}) {}
}
