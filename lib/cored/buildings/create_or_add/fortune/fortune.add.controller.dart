// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/building.edit.controller.dart';
// import 'package:smb_builder_web_client/pages/room/room.controller.dart';
// import 'package:smb_builder_web_client/pages/room/roomedit/room.edit.controller.dart';
// import 'package:smb_builder_web_client/pages/shared/model/room.model.dart';

// import 'fortune.add.provider.dart';

// class AddFortuneInBuildingController extends GetxController {
//   late TextEditingController searchController;
//   int count = 0;
//   final FortuneProvider provider = FortuneProvider();
//   final RxList<Services> services = <Services>[].obs;
//   final RxList<Services> chooseService = <Services>[].obs;
//   final Rx<String> buildingId = ''.obs;
//   final Rx<TypeContant> type = TypeContant.building.obs;

//   final RxBool checkAll = false.obs;
//   final Map<String, ValueNotifier<bool>> listCheckBox = {};

//   @override
//   void onInit() {
//     searchController = TextEditingController();
//     getProductFortune();
//     checkAll.listen((valueCheckAll) {
//       listCheckBox.forEach((key, value) {
//         value.value = valueCheckAll;
//       });
//     });
//     super.onInit();
//   }

//   void init(List<Services> services, String? id, TypeContant typeContaint) {
//     type.value = typeContaint;
//     chooseService.addAll(services);
//     buildingId.value = id ?? '';
//     checkService();
//   }

//   void checkService() {
//     if (services.isNotEmpty && chooseService.isNotEmpty) {
//       chooseService.forEach((service) {
//         if (listCheckBox[service.id!] == null) {
//           listCheckBox[service.id!] = ValueNotifier<bool>(true);
//         } else {
//           listCheckBox[service.id!]!.value = true;
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void cancelFix(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void addNew(BuildContext context) async {
//     var response =  await provider.addFortune(
//         chooseService.map((element) => element.id).toList(), buildingId.value, type.value);
//     if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300) {
//       try {
//         var buildingController = Get.find<BuildingsAddAndEditController>();
//         buildingController.getBuilding();
//         Navigator.pop(context);
//       } catch (e) {
//         e.printError();
//       }
//       try {
//         var roomController = Get.find<AddRoomInBuildingController>();
//         roomController.getRoom();
//         Navigator.pop(context);
//       } catch (e) {
//         e.printError();
//       }
//     }
//   }

//   void searchText(String text) async {
//     count++;
//     var tempCount = count;
//     await Future.delayed(Duration(seconds: 1), () async {
//       if (tempCount == count) {
//         getProductFortune();
//         count = 0;
//       }
//     });
//     if (count == 0) {
//       update();
//     }
//   }

//   void getProductFortune() async {
//     var response = await provider.getProductFortunes(
//       searchController.text,
//     );
//     services.clear();
//     if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300) {
//       var model = ServicesModel.fromJson(response.data);
//       services.addAll(model.services ?? []);
//       services.forEach((service) {
//         if (listCheckBox[service.id!] == null) {
//           listCheckBox[service.id!] = ValueNotifier<bool>(false);
//         }
//       });
//       checkService();
//     } else {
//       print(response.data);
//     }
//   }
// }

// enum TypeContant { building, room }
