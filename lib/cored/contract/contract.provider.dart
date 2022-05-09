import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/contract/contract.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/building.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class ContractProvider extends MyConnect {
  ContractProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getContracts(TypeListContract value) =>
      request('${Constant.baseUrl}/resident/rental-contracts', 'GET',
          headers: authController.getHeader);
}
