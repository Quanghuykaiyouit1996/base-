import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

import 'bill.controller.dart';

class BillProvider extends MyConnect {
  BillProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getInvoice(TypeListBill? type, String? contractId) =>
      type == TypeListBill.inContract
          ? request('${Constant.baseUrl}/resident/invoices', 'GET',
              headers: authController.getHeader,
              query: {'contractId': contractId})
          : request('${Constant.baseUrl}/resident/invoices', 'GET',
              headers: authController.getHeader);
}
