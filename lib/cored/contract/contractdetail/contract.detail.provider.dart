import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';

import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class ContractDetailProvider extends MyConnect {
  ContractDetailProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getContract(String? contractId) => request(
      '${Constant.baseUrl}/resident/rental-contracts/$contractId', 'GET',
      headers: authController.getHeader);

  Future<Response> getReview(String? contractId) => request(
        '${Constant.baseUrl}/resident/rental-contracts/$contractId/reviews',
        'GET',
        headers: authController.getHeader,
      );
}
