import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';

import 'contract.provider.dart';

class ContractController extends GetxController {
  final RxList<Contracts> contracts = <Contracts>[].obs;
  final Rx<TypeListContract> typeList = (TypeListContract.validate).obs;
  final ContractProvider provider = ContractProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    getContracts();
    typeList.stream.listen((event) {
      getContracts();
    });
  }

  void getContracts() async {
    var response = await provider.getContracts(typeList.value);
    contracts.clear();
    if (response.isOk && response.body != null) {
      var contractModel = ContractsModel.fromJson(response.body);

      contracts.addAll(contractModel.contracts?.where((element) =>
              typeList.value == TypeListContract.validate
                  ? element.isValidate()
                  : element.isUnValidate()) ??
          []);
    }
  }

  void changeTab(int index) {
    if (index == 0) {
      typeList.value = TypeListContract.validate;
    } else {
      typeList.value = TypeListContract.unvalidate;
    }
    getContracts();
  }
}

enum TypeListContract { validate, unvalidate }
