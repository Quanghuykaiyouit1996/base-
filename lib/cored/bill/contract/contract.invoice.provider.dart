import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class ContractInvoiceProvider extends MyConnect {
  ContractInvoiceProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getContracts({int? skip, int? take}) =>
      request('${Constant.baseUrl}/resident/rental-contracts', 'GET',
          headers: authController.getHeader,
          query: {
            if (skip != null) 'skip': skip.toString(),
            if (take != null) 'take': take.toString()
          });

  Future<Response> getInvoice(String? contractId) =>
      request('${Constant.baseUrl}/resident/invoices', 'GET',
          query: {'status': 'pending', 'contractId': contractId},
          headers: authController.getHeader);

  Future<Response> getContract(String contractId) => request(
      '${Constant.baseUrl}/resident/rental-contracts/$contractId', 'GET',
      headers: authController.getHeader);
}
