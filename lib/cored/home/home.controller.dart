import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:base/models/appointment.model.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/settings.model.dart';
import 'package:base/models/user.model.dart';

import 'home.provider.dart';

class HomeController extends GetxController {
  final List<Widget> widgets = [];
  final Rx<InfoShop> info = InfoShop().obs;
  final RxList<Invoice> billsNeedPay = <Invoice>[].obs;
  final RxMap<String, List<Invoice>> listContract =
      <String, List<Invoice>>{}.obs;
  final setting = SettingModel().obs;
  final provider = HomeProvider();

  ScrollController scrollController = ScrollController();

  ValueNotifier<bool> isScroll = ValueNotifier(false);

  void _onScroll() async {
    final currentScroll = scrollController.position.extentBefore;
    if (currentScroll > 0) {
      if (!isScroll.value) isScroll.value = true;
    } else {
      if (isScroll.value) isScroll.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    ever(setting, onSettingChange);
    getBills();
    getSetting();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void getBills() async {
    var response = await provider.getBillNeedPay();
    billsNeedPay.clear();
    listContract.clear();
    if (response.isOk && response.body != null) {
      var model = BillResponse.fromJson(response.body);
      billsNeedPay.addAll(model.invoices
              ?.where((element) => element.status == BillStatus.unpayment) ??
          <Invoice>[]);

      for (var element in billsNeedPay) {
        var contractId = element.contractId;
        if (contractId == null) return;
        if (listContract[contractId] == null) {
          listContract[contractId] = [];
        }
        listContract[contractId]!.add(element);
      }
    }
  }

  void getSetting() async {
    var response = await provider.getSetting();
    if (response.isOk) {
      var model = ThemeSettingModel.fromJson(response.body);
      setting.value = model.setting ?? SettingModel();
    }
  }

  void onSettingChange(SettingModel setting) {}
}

class Bills {}
