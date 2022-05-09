import 'package:get/get.dart';

import '../../../utils/helpes/constant.dart';
import '../auth.controller.dart';

class RegisterProvider extends GetConnect {
  RegisterProvider();
  AuthController authController = Get.find(tag: 'authController');

  void regiter({String? phoneNumber}) {}

}
