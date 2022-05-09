import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';

import 'contact.provider.dart';

class ContactController extends GetxController {
  final RxList<Contracts> contracts = <Contracts>[].obs;
  final Rx<TypeListContract> typeList = (TypeListContract.validate).obs;
  final ContratProvider provider = ContratProvider();
  final AuthController authController = Get.find(tag: 'authController');
}

enum TypeListContract { validate, unvalidate }
