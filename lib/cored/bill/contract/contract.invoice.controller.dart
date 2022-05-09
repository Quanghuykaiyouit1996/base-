import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/utils/helpes/utilities.dart';

import 'contract.invoice.provider.dart';

class ContractInvoiceController extends GetxController {
  final RxList<Contracts> contracts = <Contracts>[].obs;
  final RxMap<String, List<Invoice>> invoices = <String, List<Invoice>>{}.obs;
  final ContractInvoiceProvider provider = ContractInvoiceProvider();
  final AuthController authController = Get.find(tag: 'authController');
  String? contractId;
  bool isFull = false;
  bool isLoadMore = false;

  late ScrollController scrollController;
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);

    if (Get.arguments is String) {
      contractId = Get.arguments;
      getContract(contractId ?? '');
    } else {
      getContracts();
    }
  }

  void _scrollListener() {
    if ((scrollController.position.extentAfter) < 100 &&
        (scrollController.position.extentBefore) > 0) {
      loadMore();
    }
  }

  void loadMore() async {
    // print('loadMore');
    if (!isLoadMore && !isFull) {
      isLoadMore = true;

      var response =
          await provider.getContracts(skip: contracts.length, take: 10);
      if (response.hasError) {
        // branches.clear();
      } else {
        var contractModel = ContractsModel.fromJson(response.body);

        if ((contractModel.contracts?.length ?? 0) == 0) {
          isFull = true;
        } else {
          for (var contract in (contractModel.contracts ?? [])) {
            await getInvoice(contract.id ?? '');
          }
          contracts.addAll(contractModel.contracts ?? []);
        }
      }
      isLoadMore = false;
    }
  }

  void getContracts() async {
    Utilities.updateLoading(true);
    var response = await provider.getContracts(skip: 0, take: 10);
    Utilities.updateLoading(false);
    contracts.clear();
    if (response.isOk && response.body != null) {
      var contractModel = ContractsModel.fromJson(response.body);
      invoices.clear();
      for (var contract in (contractModel.contracts ?? [])) {
        await getInvoice(contract.id ?? '');
      }
      contracts.addAll(contractModel.contracts ?? []);
    }
  }

  void getContract(String contractId) async {
    var response = await provider.getContract(contractId);
    contracts.clear();
    if (response.isOk && response.body != null) {
      var contractModel = Contracts.fromJson(response.body['contract']);
      invoices.clear();
      await getInvoice(contractModel.id ?? '');
      contracts.add(contractModel);
    }
  }

  Future<void> getInvoice(String contractId) async {
    Utilities.updateLoading(true);
    var response = await provider.getInvoice(contractId);
    Utilities.updateLoading(false);
    if (response.isOk && response.body != null) {
      var invoiceModel = BillResponse.fromJson(response.body);
      if (invoices[contractId] == null) {
        invoices[contractId] = [];
      }
      invoices[contractId]!.clear();
      invoices[contractId]!.addAll(invoiceModel.invoices
              ?.where((element) => element.contractId == contractId) ??
          []);
    }
  }
}
