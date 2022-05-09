import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';

import 'bill.provider.dart';

class BillController extends GetxController {
  final RxList<Invoice> invoices = <Invoice>[].obs;
  final Rx<Contracts> contract = Contracts().obs;

  TypeListBill type = TypeListBill.all;
  final BillProvider provider = BillProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments == null) {
      type = TypeListBill.all;
    } else {
      if (Get.arguments is Contracts) {
        contract.value = Get.arguments;
        type = TypeListBill.inContract;
      }
    }
    getContracts();
  }

  void getContracts() async {
    var response = await provider.getInvoice(type, contract.value.id);
    invoices.clear();
    if (response.isOk && response.body != null) {
      var invoicesModel = BillResponse.fromJson(response.body);
      invoices.addAll(invoicesModel.invoices ?? []);
      invoices.removeWhere((element) => element.status == BillStatus.cancel);
      contract.value = invoices
              .firstWhere((element) => element.contractId != null,
                  orElse: () => Invoice())
              .contract ??
          contract.value;
    }
  }
}

enum TypeListBill { inContract, all }
