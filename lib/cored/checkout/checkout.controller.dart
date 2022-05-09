import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/payment.method.model.dart';

import 'checkout.provider.dart';

class CheckoutController extends GetxController {
  Invoice? invoice;
  final Rx<Methods?> paymentMenthod = Methods(name: 'COD', method: 'COD').obs;
  final RxList<Methods> paymentMethods = <Methods>[].obs;
  final CheckoutProvider provider = CheckoutProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Invoice) {
      invoice = Get.arguments;
    }
    getPaymentMethod();
  }

  void getPaymentMethod() async {
    var response = await provider.getPaymentMethod();
    paymentMethods.clear();
    if (response.isOk && response.body != null) {
      var model = PaymentMethodModel.fromJson(response.body);
      paymentMethods.addAll(model.methods ?? []);
      paymentMethods
          .add(Methods(name: 'Thanh toán bằng ngân lượng', method: 'NL'));
      paymentMenthod.value = paymentMethods.firstWhere((element) => true,
          orElse: () => Methods(name: 'COD', method: 'COD'));
    }
  }

  void changeDelivery(Methods? value) {
    paymentMenthod.value = value ?? Methods(name: 'COD', method: 'COD');
  }
}

enum TypeListBill { inContract, all }
