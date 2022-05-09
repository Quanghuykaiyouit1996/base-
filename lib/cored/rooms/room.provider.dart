import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/contract/contract.controller.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/building.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class RoomProvider extends MyConnect {
  RoomProvider();

  AuthController authController = Get.find(tag: 'authController');

  getRooms({required int skip, required int take}) {}
}
