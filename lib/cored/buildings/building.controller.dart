import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/building.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/address.base.controller.dart';

import 'building.edit.provider.dart';

class BuildingController extends GetxController {
  final addressBaseController = Get.put(
      AddressBaseController(addressModel: AddressModel()),
      tag: 'bodyBuildingController');
  bool isFull = false;
  bool isLoadMore = false;
  late ScrollController controller;

  late TextEditingController searchController;
  int count = 0;
  BuildingController();
  final BuildingProvider provider = BuildingProvider();
  final List<Buildings> buildings = <Buildings>[].obs;
  final RxString address = ''.obs;
  var countOnePage = 20;

  @override
  void onInit() {
    super.onInit();

    searchController = TextEditingController();
    controller = ScrollController()..addListener(_scrollListener);
    addressBaseController.init(AddressModel());

    getBuilding();
  }

  void _scrollListener() {
    if ((controller.position.extentAfter) < 100 &&
        (controller.position.extentBefore) > 0) {
      loadMore();
    }
  }

  void loadMore() async {
    if (!isLoadMore && !isFull) {
      isLoadMore = true;
      var response = await provider.getBuildings(
        addressBaseController.city.value.id,
        addressBaseController.district.value.id,
        addressBaseController.ward.value.id,
        searchController.text,
        countOnePage,
        buildings.length,
      );
      if (response.hasError) {
        // branches.clear();
      } else {
        var buildingModel = BuildingModel.fromJson(response.body);
        if ((buildingModel.buildings?.length ?? 0) == 0) {
          isFull = true;
        } else {
          buildings.addAll(buildingModel.buildings!);
          update();
        }
      }
      isLoadMore = false;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getBuilding() async {
    Utilities.updateLoading(true);
    var response = await provider.getBuildings(
      addressBaseController.city.value.id,
      addressBaseController.district.value.id,
      addressBaseController.ward.value.id,
      searchController.text,
      countOnePage,
      0,
    );
    Utilities.updateLoading(false);
    buildings.clear();
    if (response.isOk && response.body != null) {
      var model = BuildingModel.fromJson(response.body);
      buildings.addAll(model.buildings ?? []);
    } else {}
    isFull = false;
    isLoadMore = false;
  }

  void confirmDelete(Buildings? building, BuildContext context) {
    //  ConfirmDialog.open(
    //     context,
    //     'Xoá chương trình',
    //     'Bạn có chắc muốn xoá chương trình ${building!.name} ?',
    //     'Đóng',
    //     'Xoá',
    //     () async {
    //       var response = await provider.deleteBuilding(

    //       );
    //       if(response.)
    //     });
  }

  void hidden(BuildContext context, {Buildings? building}) async {
    // var response = await provider.hiddenBuilding(
    //     building?.id, !(building?.hidden ?? false));

    // if (response.statusCode! >= 200 && response.statusCode! < 300) {
    //   getBuilding();
    // } else {
    //   print(response.data);
    // }
  }

  void resetAddress() {
    addressBaseController.resetData();
  }

  void updateAddress() {
    var listTemp = <String>[];
    if (addressBaseController.ward.value.id != null) {
      listTemp.add(addressBaseController.ward.value.name ?? '');
    }
    if (addressBaseController.district.value.id != null) {
      listTemp.add(addressBaseController.district.value.name ?? '');
    }
    if (addressBaseController.city.value.id != null) {
      listTemp.add(addressBaseController.city.value.name ?? '');
    }
    address.value = listTemp.join(',').trim();
  }
}
