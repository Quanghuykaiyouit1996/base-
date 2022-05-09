import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

import 'checkout.controller.dart';

class CheckoutProvider extends MyConnect {
  CheckoutProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getInvoice(TypeListBill? type, String? contractId) =>
      type == TypeListBill.inContract
          ? request('${Constant.baseUrl}/resident/invoices', 'GET',
              headers: authController.getHeader,
              query: {'contractId': contractId})
          : request('${Constant.baseUrl}/resident/invoices', 'GET',
              headers: authController.getHeader);

  Future<Response> getPaymentMethod() =>
      request('${Constant.baseUrl}/payment/methods', 'GET',
          headers: authController.getHeader);
}
