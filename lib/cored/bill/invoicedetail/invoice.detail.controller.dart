import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';

import 'invoice.detail.provider.dart';

class InvoiceDetailController extends GetxController {
  final Rx<Invoice> invoice = Invoice().obs;

  TypeListBill type = TypeListBill.all;
  String? invoiceId;
  final InvoiceDetailProvider provider = InvoiceDetailProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    invoiceId = Get.arguments;
    getInvoices();
  }

  void getInvoices() async {
    var response = await provider.getInvoice(invoiceId);

    if (response.isOk && response.body != null) {
      var invoicesModel = Invoice.fromJson(response.body['invoice']);

      invoice.value = invoicesModel;
    }
  }
}

enum TypeListBill { inContract, all }
