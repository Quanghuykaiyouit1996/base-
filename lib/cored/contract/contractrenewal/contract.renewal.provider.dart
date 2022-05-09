import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class ContractRenewalProvider extends MyConnect {
  ContractRenewalProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getContract(String? contractId) => request(
      '${Constant.baseUrl}/resident/rental-contracts/$contractId', 'GET',
      headers: authController.getHeader);

  Future<Response> renewelContract(
          String? contractId, int month, String? note) =>
      request(
          '${Constant.baseUrl}/resident/rental-contracts/$contractId/extensions',
          'POST',
          body: {'months': month, 'note': note},
          headers: authController.getHeader);
}
