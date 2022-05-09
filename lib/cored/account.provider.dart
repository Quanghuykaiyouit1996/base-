import 'package:get/get.dart';
import 'package:base/utils/service/my.connect.dart';

import 'auth/auth.controller.dart';

class AccountProvider extends MyConnect {
  AccountProvider();

  final authController = Get.find<AuthController>(tag: 'authController');
}
