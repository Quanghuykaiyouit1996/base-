import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/buildings/building.controller.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/building.model.dart';
import 'package:base/models/room.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/helpes/validator.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/dialog.widget.dart';
import 'package:base/widgets/image.list.dart';

import 'package:html/parser.dart';

import '../building.edit.provider.dart';
import 'components/roomInfo/room.provide.dart';

class BuildingsInfoController extends GetxController {
  String? buildingId;
  final RxList<String> imagesBase64 = <String>[].obs;
  final RxList<File> imagesFile = <File>[].obs;
  final RxList<String> imagesLink = <String>[].obs;
  final RxString description = ''.obs;

  final RxList<BuildingService> services = <BuildingService>[].obs;

  final Map<String, ValueNotifier<bool>> listCheckBox = {};

  final HtmlEditorController htmlController = HtmlEditorController();

  // final RxBool isAddressDiable = false.obs;

  final BuildingProvider provider = BuildingProvider();
  final Rx<Buildings> building = Buildings().obs;

  List<Services> listServicesTypeService = <Services>[];
  List<Services> listServicesTypeDevice = <Services>[];
  List<Services> listServicesTypeFortune = <Services>[];
  List<Services> listServicesTypeRule = <Services>[];

  final RoomProvider roomProvider = RoomProvider();
  final List<Room> rooms = <Room>[].obs;

  final RxList<String> listTag = <String>[].obs;

  late TextEditingController buildingNameController;

  final Rx<BuildingType> buildingType = BuildingType().obs;
  final RxList<BuildingType> buildingTypes = <BuildingType>[].obs;
  String? Function(String value) get validateBuildingType => (String value) {
        if (value.isEmpty) {
          return 'H??y ch???n ki???u nh?? c???a b???n';
        }
        return null;
      };

  String? Function(String value) get floorValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p s??? t???ng';
        }
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        return null;
      };

  String? Function(String value) get roomValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p s??? ph??ng';
        }
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        return null;
      };

  String? Function(String value) get areaFloorValidator => (String value) {
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        return null;
      };

  String? Function(String value) get areaValidator => (String value) {
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        return null;
      };

  String get htmlToString => description.value.split("****").isEmpty
      ? ''
      : parse(parse(description.value).body!.text)
          .documentElement!
          .text
          .split("****")
          .first
          .split('Video')
          .first;

  late TextEditingController areaAllController;

  late TextEditingController tagEditorController;

  late TextEditingController dateEletricController;

  late TextEditingController datePayCostController;

  late TextEditingController areaFloorController;

  late TextEditingController buildingTypeController;

  late AddressBaseController addressController;

  late TextEditingController detailAdressController;

  late TextEditingController floorTextController;

  late TextEditingController roomTextController;

  late TextEditingController nameTextController;

  late TextEditingController phoneTextController;

  late TextEditingController mailTextController;

  late ImageListController imageListController;

  String? Function(String value) get nameValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p t??n ch??? ?????u t??';
        }

        return null;
      };

  String? Function(String value) get phoneValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p s??? ??i???n tho???i ch??? ?????u t??';
        }
        if (!Validator.validPhoneNumber(value, isSearchOrder: true)) {
          return 'H??y nh???p s??? ??i???n tho???i ';
        }
        return null;
      };

  String? Function(String value) get mailValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p email ch??? ?????u t??';
        }
        if (!value.isEmail) {
          return 'H??y nh???p email';
        }
        return null;
      };

  String? Function(String value) get buildingNameValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p t??n t??a nh??';
        }
        return null;
      };

  String? Function(String value) get dateValidatorController => (String value) {
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        if (int.tryParse(value) == null) {
          return 'Ph???i l?? s??? t??? nhi??n';
        }
        if (int.tryParse(value)! < 1 || int.tryParse(value)! > 31) {
          return 'Ph???i trong kho???ng 1 ?????n 31';
        }
        return null;
      };

  String? Function(String value) get paymentValidator => (String value) {
        if (!value.isNum) {
          return 'H??y nh???p s???';
        }
        if (int.tryParse(value) == null) {
          return 'Ph???i l?? s??? t??? nhi??n';
        }
        if (int.tryParse(value)! < 1 || int.tryParse(value)! > 31) {
          return 'Ph???i trong kho???ng 1 ?????n 31';
        }
        return null;
      };

  String? Function(String value) get addressDetailValidator => (String value) {
        if (value.isEmpty) {
          return 'H??y nh???p ?????a ch??? c??? th???';
        }
        if (value.length < 3) {
          return '?????a ch??? c??? th??? ph???i c?? ??t nh???t 3 k?? t???';
        }
        return null;
      };

  @override
  void onInit() {
    super.onInit();
    buildingId = Get.arguments;
    imageListController =
        ImageListController(imagesBase64, imagesFile, imagesLink, 100);
    buildingNameController = TextEditingController();
    buildingTypeController = TextEditingController();
    detailAdressController = TextEditingController();
    areaAllController = TextEditingController();
    tagEditorController = TextEditingController();
    areaFloorController = TextEditingController();
    floorTextController = TextEditingController();
    roomTextController = TextEditingController();
    nameTextController = TextEditingController();
    phoneTextController = TextEditingController();
    dateEletricController = TextEditingController();
    datePayCostController = TextEditingController();
    mailTextController = TextEditingController();
    addressController = Get.put(
        AddressBaseController(addressModel: AddressModel()),
        tag: 'buildingEdit');
    addressController.init(AddressModel());
    getBuildingType();
    getListServices();
    if (buildingId != null) {
      getBuilding();
      getListRoom();
    } else {
      updateData();
    }
  }

  @override
  void dispose() {
    buildingNameController.dispose();
    dateEletricController.dispose();
    datePayCostController.dispose();
    buildingTypeController.dispose();
    roomTextController.dispose();
    floorTextController.dispose();
    detailAdressController.dispose();
    nameTextController.dispose();
    areaFloorController.dispose();
    areaAllController.dispose();
    phoneTextController.dispose();
    mailTextController.dispose();
    tagEditorController.dispose();
    super.dispose();
  }

  void createListServicesOnType() {
    if (building.value.services != null) {
      listServicesTypeService.addAll(building.value.services?.where((element) =>
              element.type == TypeService.service.toShortString()) ??
          []);
      listServicesTypeDevice.addAll(building.value.services?.where((element) =>
              element.type == TypeService.device.toShortString()) ??
          []);
      listServicesTypeFortune.addAll(building.value.services?.where((element) =>
              element.type == TypeService.fortune.toShortString()) ??
          []);
      listServicesTypeRule.addAll(building.value.services?.where(
              (element) => element.type == TypeService.rule.toShortString()) ??
          []);
    }
  }

  void getListServices() async {
    services.clear();
    services.add(BuildingService(
        type: TypeService.fortune.toShortString(), services: <Services>[]));
    getListDevice();
    getListService();
    getListRule();
  }

  void getListService() async {
    var response =
        await provider.getListService(TypeService.service.toShortString());
    if (response.isOk && response.body != null) {
      var model = BuildingService.fromJson(response.body);
      model.services?.removeWhere((element) => element.type == null);
      model.services?.forEach((service) {
        if (!services.any((element) => element.type == service.type)) {
          services
              .add(BuildingService(type: service.type, services: <Services>[]));
        }
        var buildingService = services.firstWhere(
            (buildingService) => buildingService.type == service.type);
        buildingService.services!.add(service);
        if (listCheckBox[service.id!] == null) {
          listCheckBox[service.id!] = ValueNotifier<bool>(false);
        }
      });
    } else {
      print(response.body);
    }
  }

  void getListDevice() async {
    var response =
        await provider.getListService(TypeService.device.toShortString());

    if (response.isOk && response.body != null) {
      var model = BuildingService.fromJson(response.body);
      model.services?.removeWhere((element) => element.type == null);
      model.services?.forEach((service) {
        if (!services.any((element) => element.type == service.type)) {
          services
              .add(BuildingService(type: service.type, services: <Services>[]));
        }
        var buildingService = services.firstWhere(
            (buildingService) => buildingService.type == service.type);
        buildingService.services!.add(service);
        if (listCheckBox[service.id!] == null) {
          listCheckBox[service.id!] = ValueNotifier<bool>(false);
        }
      });
    } else {
      print(response.body);
    }
  }

  void getListRule() async {
    var response =
        await provider.getListService(TypeService.rule.toShortString());
    if (response.isOk && response.body != null) {
      var model = BuildingService.fromJson(response.body);
      model.services?.removeWhere((element) => element.type == null);
      model.services?.forEach((service) {
        if (!services.any((element) => element.type == service.type)) {
          services
              .add(BuildingService(type: service.type, services: <Services>[]));
        }
        var buildingService = services.firstWhere(
            (buildingService) => buildingService.type == service.type);
        buildingService.services!.add(service);
        if (listCheckBox[service.id!] == null) {
          listCheckBox[service.id!] = ValueNotifier<bool>(false);
        }
      });
    } else {
      print(response.body);
    }
  }

  void getBuildingType() async {
    var response = await provider.getBuildingType();
    buildingTypes.clear();
    if (response.isOk && response.body != null) {
      var model = BuildingTypesModel.fromJson(response.body);
      buildingTypes.addAll(model.building ?? []);
      updateBuildingType();
    } else {
      print(response.body);
    }
  }

  // String? baseUrl = GlobalConfiguration().get('base_url');

  // Dio dio = Dio();

  void getBuilding() async {
    var response = await provider.getBuilding(buildingId);
    if (response.isOk && response.body != null) {
      var model = Buildings.fromJson(response.body['building']);
      building.value = model;
      updateData();
      createListServicesOnType();
    } else {
      print(response.body);
    }
  }

  void updateBuildingType() {
    if (buildingType.value.name == null &&
        building.value.type != null &&
        buildingTypes.isNotEmpty) {
      buildingType.value = buildingTypes.firstWhere(
          (element) => element.name == building.value.type,
          orElse: () => BuildingType());
      buildingTypeController.text = buildingType.value.name ?? '';
    }
  }

  Future<void> getListRoom() async {
    var response = await roomProvider.getAllRoom(buildingId);
    rooms.clear();
    if (response.isOk && response.body != null) {
      var model = RoomModel.fromJson(response.body);
      rooms.addAll(model.rooms ?? []);
    } else {
      print(response.body);
    }
  }

  // void cancelFix(BuildContext context) {
  //   Navigator.pop(context);
  // }

  // void addNew(BuildContext context) async {
  //   var listIdServiceChoose = <String>[];
  //   listCheckBox.forEach((key, value) {
  //     if (value.value) {
  //       listIdServiceChoose.add(key);
  //     }
  //   });
  //   var response = await provider.addBuilding(
  //       imageListController.imagesLink,
  //       listTag.map((element) => element).toList(),
  //       listIdServiceChoose,
  //       buildingNameController.text,
  //       nameTextController.text,
  //       phoneTextController.text,
  //       mailTextController.text,
  //       addressController.district,
  //       addressController.ward,
  //       detailAdressController.text,
  //       floorTextController.text,
  //       roomTextController.text,
  //       areaAllController.text,
  //       areaFloorController.text,
  //       dateEletricController.text,
  //       datePayCostController.text,
  //       buildingType.value.name,
  //       quillController.document.toPlainText());

  //   if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //     await Navigator.pushReplacementNamed(context, '/buildings');
  //     try {
  //       var buildingController = Get.find<BuildingController>();
  //       buildingController.getBuilding();
  //     } on Exception catch (e) {}
  //   } else {
  //     print(response.data);
  //   }
  // }

  void changeInfo(BuildContext context) async {
    var listIdServiceChoose = <String>[];
    listCheckBox.forEach((key, value) {
      if (value.value) {
        listIdServiceChoose.add(key);
      }
    });
    var response = await provider.changeDataBuilding(
        imageListController.imagesLink,
        listTag.map((element) => element).toList(),
        listIdServiceChoose,
        buildingNameController.text,
        nameTextController.text,
        phoneTextController.text,
        mailTextController.text,
        detailAdressController.text,
        floorTextController.text,
        roomTextController.text,
        areaFloorController.text,
        areaAllController.text,
        dateEletricController.text,
        datePayCostController.text,
        buildingType.value.name,
        description.value,
        buildingId);

    if (response.isOk) {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
            Get.back();
            Get.toNamed(Routes.BUILDING_INFO);
          },
          title: 'Th??ng b??a',
          description: 'Ch???nh s???a th??ng tin th??nh c??ng'));
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Th??ng b??a',
          description: 'Ch???nh s???a th??ng tin kh??ng th??nh c??ng'));
    }
  }

  // void createService(BuildingService service, BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       var controller = Get.put(AddServiceInBuildingController());
  //       controller.init(service.type ?? '',
  //           services.map((element) => element.type ?? '').toList(), null);
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content: AddServiceInBuildingDialog(controller),
  //       );
  //     },
  //   );
  // }

  void updateData() async {
    nameTextController.text = '';
    addressController.init(AddressModel());
    buildingNameController.text = '';
    detailAdressController.text = '';
    floorTextController.text = '0';
    roomTextController.text = '0';
    nameTextController.text = '';
    phoneTextController.text = '';
    mailTextController.text = '';
    description.value = '';
    imagesLink.clear();
    imagesBase64.clear();
    imagesFile.clear();

    areaAllController.text = '0';
    areaFloorController.text = '0';
    dateEletricController.text = '';
    datePayCostController.text = '';
    listTag.clear();
    if (building.value.id != null) {
      nameTextController.text = building.value.name ?? '';
      addressController.init(building.value.address ?? AddressModel());
      // addressController.disableDropBox();
      // isAddressDiable.value = true;
      buildingNameController.text = building.value.name ?? '';
      detailAdressController.text = building.value.address?.address1 ?? '';
      floorTextController.text = building.value.floorCount?.toString() ?? '0';
      roomTextController.text = building.value.roomCount?.toString() ?? '0';
      nameTextController.text = building.value.owner?.name ?? '';
      phoneTextController.text = building.value.owner?.phoneNumber ?? '';
      mailTextController.text = building.value.owner?.email ?? '';

      imagesLink
          .addAll(building.value.images?.map((e) => e.source ?? '') ?? []);
      areaAllController.text = building.value.totalArea?.toString() ?? '0';
      areaFloorController.text = building.value.floorArea?.toString() ?? '0';
      dateEletricController.text =
          building.value.rentalBillSettleDate?.toString() ?? '0';
      datePayCostController.text =
          building.value.utilitiesBillSettleDate?.toString() ?? '0';

      description.value = building.value.description ?? '';

      listTag.addAll(building.value.tags ?? []);
      var fortuneService = services.firstWhere(
          (element) => element.type == TypeService.fortune.toShortString(),
          orElse: () => BuildingService());
      for (var service in building.value.services!) {
        if (listCheckBox[service.id!] == null) {
          listCheckBox[service.id!] = ValueNotifier<bool>(true);
        } else {
          listCheckBox[service.id!]!.value = true;
        }
        if (service.type == TypeService.fortune.toShortString() &&
            fortuneService.type != null) {
          fortuneService.services?.add(service);
        }
      }
      updateBuildingType();
    } else {
      // addressController.enableDropBox();

    }
    update();
  }

  void openEditor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
                child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: const Text('M?? t??? s???n ph???m')),
                  Expanded(
                    child: HtmlEditor(
                      controller: htmlController, //required
                      htmlEditorOptions: HtmlEditorOptions(
                          initialText: description.value,
                          hint: 'Nh???p text ??? ????y',
                          autoAdjustHeight: true),
                      htmlToolbarOptions: HtmlToolbarOptions(
                        toolbarPosition:
                            ToolbarPosition.aboveEditor, //by default
                        toolbarType: ToolbarType.nativeGrid, //by default

                        onButtonPressed: (ButtonType type, bool? status,
                            Function()? updateStatus) {
                          return true;
                        },

                        onDropdownChanged: (DropdownType type, dynamic changed,
                            Function(dynamic)? updateSelectedItem) {
                          return true;
                        },
                        mediaLinkInsertInterceptor:
                            (String url, InsertFileType type) {
                          return true;
                        },
                      ),
                      otherOptions: OtherOptions(
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: SmallButton(
                              iconSize: const Size(double.infinity, 40),
                              text: 'Tho??t',
                              color: Colors.grey,
                              textColor: Colors.black,
                              function: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SmallButton(
                              iconSize: const Size(double.infinity, 40),
                              color: Colors.green,
                              text: 'L??u',
                              function: () async {
                                Navigator.pop(context);
                                description.value =
                                    await htmlController.getText();
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }

  // void goToListRoom(BuildContext context) {
  //   Navigator.pushReplacementNamed(context, '/rooms/${building.value.id}');
  // }

  // void addFortune(BuildingService service, BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       try {
  //         Get.delete<AddFortuneInBuildingController>();
  //       } on Exception catch (e) {
  //         e.printError();
  //       }
  //       var controller = Get.put(AddFortuneInBuildingController());
  //       controller.init(
  //           service.services
  //                   ?.map((element) => Services(id: element.id))
  //                   .toList() ??
  //               [],
  //           building.value.id, TypeContant.building);
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content: AddFortuneInBuildingDialog(controller),
  //       );
  //     },
  //   );
  // }
}
