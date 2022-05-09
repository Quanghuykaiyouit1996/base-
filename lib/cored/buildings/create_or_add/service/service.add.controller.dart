// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:smb_builder_web_client/pages/buildingproductfortune/%1Dbuilding.product.fortune.controller.dart';
// import 'package:smb_builder_web_client/pages/buildingproductservice/%1Dbuilding.product.service.controller.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/building.edit.controller.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/components/image.list.dart';
// import 'package:smb_builder_web_client/pages/product-service/product-service.model.dart';
// import 'package:smb_builder_web_client/pages/shared/model/room.model.dart';

// import 'service.add.provider.dart';

// class AddServiceInBuildingController extends GetxController {
//   final quillController = QuillController.basic();
//   final Rx<String> type = ''.obs;
//   final RxList<String> imagesBase64 = <String>[].obs;
//   final RxList<File> imagesFile = <File>[].obs;
//   final RxList<String> imagesLink = <String>[].obs;
//   final RxList<String> listType = <String>[].obs;
//   final Rx<Services> service = Services().obs;
//   late ImageListController imageListController;
//   final ServiceProvider provider = ServiceProvider();

//   final RxList<String> listTag = <String>[].obs;

//   late TextEditingController serviceNameController;

//   late TextEditingController tagEditorController;

//   late TextEditingController unitNameController;

//   late TextEditingController priceController;

//   late TextEditingController serviceTypeController;

//   String? Function(String value) get priceValidator => (String value) {
//         if (value.isEmpty) {
//           return 'Hãy nhập giá';
//         }
//         return null;
//       };

//   String? Function(String value) get serviceNameValidator => (String value) {
//         if (value.isEmpty) {
//           return 'Hãy nhập tên sản phẩm';
//         }
//         return null;
//       };

//   String? Function(String value) get serviceTypeValidator => (String value) {
//         if (value.isEmpty) {
//           return 'Hãy chọn kiểu sản phẩm';
//         }
//         return null;
//       };

//   get listCheckBox => null;

//   @override
//   void onInit() {
//     tagEditorController = TextEditingController();
//     serviceNameController = TextEditingController();

//     tagEditorController = TextEditingController();

//     unitNameController = TextEditingController();

//     priceController = TextEditingController();

//     serviceTypeController = TextEditingController();
//     if (type.value.isNotEmpty) {
//       serviceTypeController.text = type.value;
//     }
//     imageListController =
//         ImageListController(imagesBase64, imagesFile, imagesLink, 100);
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     tagEditorController.dispose();
//     super.dispose();
//   }

//   void cancelFix(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void addNew(BuildContext context) async {
//     if (service.value.id == null) {
//       var response = await provider.addNewService(
//           imageListController.imagesLink.map((element) => element).toList(),
//           type.value,
//           serviceNameController.text,
//           priceController.text,
//           unitNameController.text,
//           quillController.document.toPlainText(),
//           listTag);
//       if ((response.statusCode ?? 0) >= 200 &&
//           (response.statusCode ?? 0) < 300) {
//         var model = ServiceModel.fromJson(response.data['service']);
//         try {
//           var buildingEditController =
//               Get.find<BuildingsAddAndEditController>();
//           var buildingService = buildingEditController.services.firstWhere(
//               (element) => model.type == element.type,
//               orElse: () => BuildingService());
//           if (buildingService.type != null) {
//             buildingService.services!.add(model);
//           }
//           buildingEditController.listCheckBox[model.id!] = ValueNotifier(false);
//           buildingEditController
//               .update(['listBuildingService${buildingService.type}']);
//         } catch (e) {
//           e.printError();
//         }
//         try {
//           var listService = Get.find<BuildingServiceController>();
//           listService.getProductService();
//         } catch (e) {
//           e.printError();
//         }
//         try {
//           var listService = Get.find<BuildingFortuneController>();
//           listService.getProductFortune();
//         } catch (e) {
//           e.printError();
//         }
//       }
//     } else {
//       var response = await provider.updateService(
//           imageListController.imagesLink.map((element) => element).toList(),
//           type.value,
//           serviceNameController.text,
//           priceController.text,
//           unitNameController.text,
//           quillController.document.toPlainText(),
//           listTag,
//           service.value.id);
//       if ((response.statusCode ?? 0) >= 200 &&
//           (response.statusCode ?? 0) < 300) {
//         try {
//           var listService = Get.find<BuildingServiceController>();
//           listService.getProductService();
//         } catch (e) {
//           print('aaa');
//           e.printError();
//         }
//       } else {
//         print(response.data);
//       }
//     }

//     Navigator.pop(context);
//   }

//   void init(String typeService, List<String> list, Services? tempService) {
//     listType.clear();
//     listType.addAll(list);
//     type.value =
//         list.firstWhere((element) => element == typeService, orElse: () => '');
//     serviceTypeController.text = type.value;
//     if (tempService?.id != null) {
//       service.value = tempService!;
//     }
//     resetData();
//   }

//   void resetData() {
//     if (service.value.id == null) {
//       imagesBase64.clear();
//       imagesFile.clear();
//       imagesLink.clear();
//       serviceNameController.text = '';
//       unitNameController.text = '';
//       priceController.text = '';

//       listTag.clear();
//       if (quillController.document.toPlainText().trim().isNotEmpty) {
//         var length = quillController.document.toPlainText().trim().length;
//         quillController.replaceText(
//             0, length, '', TextSelection(baseOffset: 0, extentOffset: 0));
//       }
//     } else {
//       imagesBase64.clear();
//       imagesFile.clear();
//       imagesLink.clear();
//       imagesLink.addAll(service.value.images?.map((e) => e.source ?? '') ?? []);
//       serviceNameController.text = service.value.name ?? '';
//       unitNameController.text = service.value.unit ?? '';
//       priceController.text = service.value.maxPrice.toString();
//       type.value = listType.firstWhere(
//           (element) => element == service.value.type,
//           orElse: () => '');
//       serviceTypeController.text = type.value;
//       listTag.clear();
//       listTag.addAll(service.value.tags ?? []);
//       if (quillController.document.toPlainText().trim().isNotEmpty) {
//         var length = quillController.document.toPlainText().trim().length;
//         quillController.replaceText(
//             0, length, '', TextSelection(baseOffset: 0, extentOffset: 0));
//       }
//     }
//   }

//   void getTypeService() {}
// }
