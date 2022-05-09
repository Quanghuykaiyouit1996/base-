import 'dart:convert';

import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/fake_data/building.type.fake.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class RoomDetailProvider extends MyConnect {
  final authController = Get.find<AuthController>(tag: 'authController');

  getRoom(String? roomId) {}
}
