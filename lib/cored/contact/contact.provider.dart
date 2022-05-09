import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/service/my.connect.dart';

class ContratProvider extends MyConnect {
  ContratProvider();

  AuthController authController = Get.find(tag: 'authController');
}
