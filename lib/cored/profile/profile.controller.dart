import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/auth/register/register.provider.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/helpes/validator.dart';
import 'package:base/utils/service/file.service.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:base/widgets/dialog.widget.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  final authController = Get.find<AuthController>(tag: 'authController');
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  BuildContext? context;

  final RxString frontImageUrl = ''.obs;
  final RxString backImageUrl = ''.obs;
  final Rx<File> frontFile = File('').obs;
  final Rx<File> backFile = File('').obs;
  final RxString frontImage = ''.obs;
  final RxString backImage = ''.obs;
  final RxString dateOfBirth = ''.obs;
  final picker = ImagePicker();
  final Rx<String> imageUrl = ''.obs;

  int maxFileSize = 5242880;

  final Rx<Sex> sex = Sex.diffirent.obs;

  late TextEditingController sexController;

  String? Function(String value) get taxLocationValidator => (String value) {
        return null;
      };

  String? Function(String value) get taxDateValidator => (String value) {
        return null;
      };

  final AddressBaseController addressController =
      AddressBaseController(addressModel: AddressModel());

  @override
  void onInit() {
    var partner = authController.user;
    emailController = TextEditingController()..text = partner.email ?? '';

    nameController = TextEditingController()..text = partner.name ?? '';

    phoneController = TextEditingController()..text = partner.phoneNumber ?? '';

    sexController = TextEditingController()..text = partner.gender ?? '';
    sex.value = partner.sex;
    bankNameController = TextEditingController()
      ..text = partner.bankAccountBankInfo ?? '';

    accountNameController = TextEditingController()
      ..text = partner.bankAccountOwnerName ?? '';

    accountNumberController = TextEditingController()
      ..text = partner.bankAccountNumber ?? '';
    imageUrl.value = partner.photoUrl ?? '';
    dateOfBirth.value = Convert.stringToDateAnotherPattern(partner.dob ?? '',
        patternIn: 'yyyy-MM-dd', patternOut: 'dd/MM/yyyy');
    addressController.init(AddressModel());
    cMNDNumberController = TextEditingController()..text = partner.ssn ?? '';
    if (partner.sscImages != null && partner.sscImages!.isNotEmpty) {
      frontImageUrl.value = partner.sscImages?[0] ?? '';
    }
    if (partner.sscImages != null && partner.sscImages!.length > 1) {
      backImageUrl.value = partner.sscImages?[1] ?? '';
    }

    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();

    nameController.dispose();

    phoneController.dispose();

    bankNameController.dispose();

    accountNameController.dispose();

    accountNumberController.dispose();

    cMNDNumberController.dispose();

    taxController.dispose();

    super.dispose();
  }

  late TextEditingController emailController;

  late TextEditingController taxDateController;

  late TextEditingController taxLocationController;

  late TextEditingController taxController;

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController bankNameController;

  late TextEditingController accountNameController;

  late TextEditingController accountNumberController;

  late TextEditingController cMNDNumberController;

  String? Function(String value) get emailValidator => (String value) {
        if (!Validator.validEmail(value)) {
          return 'Email không hợp lệ';
        }
        return null;
      };

  String? Function(String value) get nameValidator => (String value) {
        return null;
      };

  String? Function(String value) get taxValidator => (String value) {
        return null;
      };

  String? Function(String value) get phoneValidator => (String value) {
        if (!Validator.validPhoneNumber(value.split(' ').join().trim())) {
          return 'Số điện thoại không hợp lệ';
        }
        return null;
      };

  String? Function(String value) get bankNameValidator => (String value) {
        if (!Validator.validBankNumber(value.split(' ').join().trim())) {
          return 'Số tài khoản ngân hàng không hợp lệ';
        }
        return null;
      };

  String? Function(String value) get accountNameValidator => (String value) {
        if (value.isNotEmpty && value.length < 6) {
          return 'Tên chủ tài khoản phải có ít nhất 6 ký tự';
        }
        return null;
      };

  String? Function(String value) get accountNumberValidator => (String value) {
        if (value.isNotEmpty && value.length < 8) {
          return 'Số tài khoản phải có ít nhất 8 ký tự';
        }
        if (!Validator.validBankNumber(value)) {
          return 'Tài khoản ngân hàng phải là chuỗi số và chữ cái không dấu';
        }
        return null;
      };

  String? Function(String value) get cMNDNumberValidator => (String value) {
        if (!Validator.validCMNDNumber(value.split(' ').join().trim())) {
          return 'Số CMND không hợp lệ';
        }
        return null;
      };

  void updateUser() async {
    var response = await authController.updateUser(
      phoneController.text,
      imageUrl.value,
      nameController.text,
      dateOfBirth.value,
      sex.value.signal(),
      cMNDNumberController.text,
      frontImageUrl.value,
      backImageUrl.value,
      accountNumberController.text,
      accountNameController.text,
      bankNameController.text,
    );
    if (response.isOk) {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'Chỉnh sửa thông tin thành công'));
      authController.getUserInfo();
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: response.body.toString()));
    }
  }

  void changeAvatar() {
    Get.bottomSheet(
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  try {
                    var status = await Permission.camera.status;
                    if (status.isPermanentlyDenied) {
                      await showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                title: const Text('Camera Permission'),
                                content: const Text(
                                    'Bạn đã chặn quyền sử dụng camera , hãy đến màn hình cài đặt và cài đặt quyền cho ứng dụng '),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Từ chối'),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () => openAppSettings(),
                                    child: const Text('Cài đặt'),
                                  ),
                                ],
                              ));
                      return;
                    }
                    var pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 30,
                        maxWidth: 300,
                        maxHeight: 300);
                    if (pickedFile != null) {
                      var file = File(pickedFile.path);
                      var size = await file.length();
                      if (size > maxFileSize) {
                        Get.rawSnackbar(message: 'Ảnh tải quá nặng');
                      } else {
                        _actionUploadImage(file, 'gallery');
                      }
                    }
                  } catch (e) {
                    printError(info: e.toString());
                  }
                },
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    child: const Text('Chụp ảnh'))),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  try {
                    var status = await Permission.photos.status;
                    if (status.isPermanentlyDenied) {
                      await showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                title: const Text('Camera Permission'),
                                content: const Text(
                                    'Bạn đã chặn quyền truy cập hình ảnh , hãy đến màn hình cài đặt và cài đặt quyền cho ứng dụng '),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Từ chối'),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () => openAppSettings(),
                                    child: const Text('Cài đặt'),
                                  ),
                                ],
                              ));
                      return;
                    }
                    var pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 30,
                        maxWidth: 300,
                        maxHeight: 300);
                    if (pickedFile != null) {
                      // var fileTemp = await pickedFile.readAsBytes();
                      var file = File(pickedFile.path);

                      var size = await file.length();
                      if (size > maxFileSize) {
                        Get.rawSnackbar(message: 'Ảnh tải quá nặng');
                      } else {
                        _actionUploadImage(file, 'gallery');
                      }
                    }
                  } catch (e) {
                    printError(info: e.toString());
                  }
                },
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    child: const Text('Thư viện ảnh'))),
          ],
        ),
      ),
    );
  }

  void _actionUploadImage(File image, String source) async {
    var base64 = convertImageFileToBase64(image);
    var response = await uploadImageToServer(base64);
    if (response.isOk && response.body != null) {
      imageUrl.value = response.body['image']['publicUrl'];
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'không tải được lên hình ảnh'));
    }
  }

  Future<Response> uploadImageToServer(String? data,
      {double? width, double? height}) async {
    var fileProvider = FileProvider();
    return fileProvider.uploadImage(data, width, height);
  }

  static String convertImageFileToBase64(File image) {
    String base64Image;
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
