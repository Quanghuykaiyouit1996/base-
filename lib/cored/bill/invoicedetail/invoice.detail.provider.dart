import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

import 'invoice.detail.controller.dart';

class InvoiceDetailProvider extends MyConnect {
  InvoiceDetailProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getInvoice(String? invoiceId) =>
      request('${Constant.baseUrl}/resident/invoices/$invoiceId', 'GET',
          headers: authController.getHeader);
}
