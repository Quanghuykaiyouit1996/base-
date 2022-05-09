import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/profile/profile.controller.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/utils/service/file.service.dart';
import 'package:base/widgets/address.base.dart';
import 'package:base/widgets/button.dropdown.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/choose.date.dart';
import 'package:base/widgets/text.form.widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find(tag: 'authController');
  final ProfileController profileController = Get.put(ProfileController());

  final heightBackground = Get.size.height * 2 / 11;

  ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child:
                  const Icon(MyFlutterApp.left_open, color: Color(0xFF797C8D))),
          backgroundColor: const Color(0xFF16154E),
          titleSpacing: 0,
          shadowColor: Colors.transparent,
          title: const Text(
            'Thông tin cá nhân',
          ),
          actions: [
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (profileController.key.currentState?.validate() ?? false) {
                    profileController.updateUser();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Lưu',
                      style: TextStyle(color: Colors.yellow, fontSize: 14)),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1200,
            child: Stack(
              children: [
                Positioned(
                  top: heightBackground - 50,
                  left: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                      ),
                      padding:
                          const EdgeInsets.only(top: 50, left: 16, right: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: Get.size.width - 32,
                      child: Form(
                        key: profileController.key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            InfoAccount('Số điện thoại',
                                enable: false,
                                hintText: const ['Nhập số điện thoại'],
                                controller: [profileController.phoneController],
                                validator: [profileController.phoneValidator]),

                            InfoAccount('Họ và tên',
                                enable: false,
                                hintText: const ['Nhập họ tên'],
                                controller: [profileController.nameController],
                                validator: [profileController.nameValidator]),
                            const SizedBox(
                              height: 16,
                            ),
                            InfoAccount('Email',
                                enable: false,
                                isHasDivider: false,
                                hintText: const ['Nhập email của bạn'],
                                controller: [profileController.emailController],
                                validator: [profileController.emailValidator]),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // const Text(
                            //   'Địa chỉ thường trú',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       color: Color(0xFF9D9BC9),
                            //       fontSize: 12),
                            // ),
                            // const SizedBox(
                            //   height: 4,
                            // ),
                            // GetAddressBase(
                            //     controller:
                            //         profileController.addressController),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ngày sinh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9D9BC9),
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      ChooseDate(
                                        enable: false,
                                        textDate: profileController.dateOfBirth,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Giới tính',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9D9BC9),
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(
                                        children: [
                                          // TextFormFieldLogin(
                                          //   enable: false,
                                          //   controller:
                                          //       profileController.sexController,
                                          // ),
                                          ButtonDropdown<Sex>(
                                            enable: false,
                                            items: Sex.values,
                                            callback: (value) {
                                              profileController.sexController
                                                  .text = value.toStringShort();
                                            },
                                            hintText: 'Chọn giới tính *',
                                            selectedItem: profileController.sex,
                                            childs: Sex.values.map((item) {
                                              return DropdownMenuItem<Sex>(
                                                value: item,
                                                child:
                                                    Text(item.toStringShort()),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            InfoAccount('Thông tin số CMND',
                                enable: false,
                                hintText: const [
                                  'Nhập họ tên'
                                ],
                                controller: [
                                  profileController.cMNDNumberController
                                ],
                                validator: [
                                  profileController.cMNDNumberValidator
                                ]),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Thông tin tài khoản ngân hàng',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9D9BC9),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),

                            TextFormFieldLogin(
                                keyboardType: TextInputType.text,
                                hintText: 'Tên ngân hàng',
                                controller:
                                    profileController.bankNameController,
                                validator: profileController.bankNameValidator),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormFieldLogin(
                                keyboardType: TextInputType.number,
                                hintText: 'Số tài khoản',
                                controller:
                                    profileController.accountNumberController,
                                validator:
                                    profileController.accountNumberValidator),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormFieldLogin(
                                keyboardType: TextInputType.text,
                                hintText: 'Tên tài khoản',
                                controller:
                                    profileController.accountNameController,
                                validator:
                                    profileController.accountNameValidator),

                            // ImageCMND(
                            //   enable: false,
                            //   controller: ImageCMNDController(
                            //     profileController.frontImageUrl,
                            //     profileController.backImageUrl,
                            //     profileController.frontFile,
                            //     profileController.backFile,
                            //     profileController.frontImage,
                            //     profileController.backImage,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: Get.width / 2,
                                child: BigButton(
                                  text: 'Yêu cầu chỉnh sửa',
                                  textColor: const Color(0xFF00A79E),
                                  color: Colors.white,
                                  border: const BorderSide(
                                      color: Color(0xFF00A79E)),
                                  icon: const Icon(Icons.phone,
                                      color: Color(0xFF00A79E)),
                                  isIconFront: true,
                                  space: 2,
                                  function: () {
                                    canLaunch('tel:19002929')
                                        .then((bool result) {
                                      if (result) {
                                        launch('tel:19002929');
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                    top: heightBackground - 50 - 100 / 2,
                    width: Get.size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          profileController.changeAvatar();
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                  )
                                ], shape: BoxShape.circle, color: Colors.white),
                                padding: const EdgeInsets.all(4),
                                child: Obx(() => ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Utilities.getImageNetwork(
                                          profileController.imageUrl.value),
                                    )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 1),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFE1EAFF)),
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}

class ImageCMND extends StatelessWidget {
  final ImageCMNDController controller;
  final bool enable;
  const ImageCMND({
    Key? key,
    required this.controller,
    this.enable = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ảnh CMND',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9D9BC9),
                  fontSize: 12)),
          const SizedBox(
            height: 10,
          ),
          LayoutBuilder(builder: (context, constant) {
            var widthWidget = constant.constrainWidth();
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => controller.frontImageUrl.value.isEmpty &&
                        controller.frontImage.value.isEmpty
                    ? (enable
                        ? GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.uploadImage(true);
                            },
                            child: SizedBox(
                              width: (widthWidget - 10) / 2,
                              height: (widthWidget - 10) / 2,
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  strokeWidth: 1,
                                  dashPattern: const [6, 5],
                                  strokeCap: StrokeCap.butt,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            color: Get.theme.primaryColor,
                                            size: (widthWidget - 10) / 3,
                                          ),
                                          const Text('Mặt trước',
                                              style: TextStyle(fontSize: 14))
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        : const SizedBox.shrink())
                    : controller.frontImage.value.isNotEmpty
                        ? SizedBox(
                            width: (widthWidget - 10) / 2,
                            height: (widthWidget - 10) / 2 + 28,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: (widthWidget - 10) / 2,
                                  height: (widthWidget - 10) / 2,
                                  child: Image.file(controller.frontFile.value),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      controller.uploadImage(true);
                                    },
                                    child: Text(
                                      'Chỉnh sửa',
                                      style: TextStyle(
                                          color: Get.theme.primaryColor),
                                    )),
                              ],
                            ),
                          )
                        : SizedBox(
                            width: (widthWidget - 10) / 2,
                            height: (widthWidget - 10) / 2 + 28,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: (widthWidget - 10) / 2,
                                    height: (widthWidget - 10) / 2,
                                    child: Utilities.getImageNetwork(
                                        controller.frontImageUrl.value)),
                                const SizedBox(height: 5),
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      controller.uploadImage(true);
                                    },
                                    child: Text(
                                      'Chỉnh sửa',
                                      style: TextStyle(
                                          color: Get.theme.primaryColor),
                                    )),
                              ],
                            ),
                          )),
                const SizedBox(width: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Obx(() {
                    if (controller.backImageUrl.value.isEmpty &&
                        controller.backImage.value.isEmpty) {
                      return (enable
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.uploadImage(false);
                              },
                              child: SizedBox(
                                width: (widthWidget - 10) / 2,
                                height: (widthWidget - 10) / 2,
                                child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    strokeWidth: 1,
                                    dashPattern: const [6, 5],
                                    strokeCap: StrokeCap.butt,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              color: Get.theme.primaryColor,
                                              size: (widthWidget - 10) / 3,
                                            ),
                                            const Text('Mặt sau',
                                                style: TextStyle(fontSize: 14))
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          : const SizedBox.shrink());
                    } else {
                      return controller.backImage.value.isNotEmpty
                          ? SizedBox(
                              width: (widthWidget - 10) / 2,
                              height: (widthWidget - 10) / 2 + 28,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: (widthWidget - 10) / 2,
                                    height: (widthWidget - 10) / 2,
                                    child:
                                        Image.file(controller.backFile.value),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller.uploadImage(false);
                                      },
                                      child: Text(
                                        'Chỉnh sửa',
                                        style: TextStyle(
                                            color: Get.theme.primaryColor),
                                      )),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: (widthWidget - 10) / 2,
                              height: (widthWidget - 10) / 2 + 28,
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: (widthWidget - 10) / 2,
                                      height: (widthWidget - 10) / 2,
                                      child: Utilities.getImageNetwork(
                                          controller.backImageUrl.value)),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller.uploadImage(false);
                                      },
                                      child: Text(
                                        'Chỉnh sửa',
                                        style: TextStyle(
                                            color: Get.theme.primaryColor),
                                      )),
                                ],
                              ),
                            );
                    }
                  }),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class ImageCMNDController {
  final RxString frontImageUrl;
  final RxString backImageUrl;
  final RxString frontImage;
  final RxString backImage;
  final Rx<File> frontFile;
  final Rx<File> backFile;
  int maxFileSize = 5242880;
  final picker = ImagePicker();

  ImageCMNDController(this.frontImageUrl, this.backImageUrl, this.frontFile,
      this.backFile, this.frontImage, this.backImage);

  void uploadImage(bool isFront) {
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
                                title: const Text('Quyền truy cập camera'),
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
                        imageQuality: 100,
                        maxWidth: 500,
                        maxHeight: 500);
                    if (pickedFile != null) {
                      var file = File(pickedFile.path);
                      var size = await file.length();
                      if (size > maxFileSize) {
                        Get.rawSnackbar(message: 'Ảnh tải quá nặng');
                      } else {
                        _actionUploadImage(file, 'gallery', isFront);
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
                                title: const Text('Quyền truy cập hình ảnh'),
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
                        imageQuality: 100,
                        maxWidth: 500,
                        maxHeight: 500);
                    if (pickedFile != null) {
                      // var fileTemp = await pickedFile.readAsBytes();
                      var file = File(pickedFile.path);

                      var size = await file.length();

                      if (size > maxFileSize) {
                        Get.rawSnackbar(message: 'Ảnh tải quá nặng');
                      } else {
                        _actionUploadImage(file, 'gallery', isFront);
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

  void _actionUploadImage(File image, String source, bool isFrontImage) async {
    Utilities.updateLoading(true, timeTimeOut: 60);
    var base64 = Utilities.convertImageFileToBase64(image);
    var response = await uploadImageToServer(base64);
    Utilities.updateLoading(false, timeTimeOut: 60);
    if (response.isOk && response.body != null) {
      if (isFrontImage) {
        frontImageUrl.value = response.body['image']['publicUrl'];
        frontImage.value = base64;
        frontFile.value = image;
      } else {
        backImageUrl.value = response.body['image']['publicUrl'];
        backImage.value = base64;
        backFile.value = image;
      }
    }
  }

  Future<Response> uploadImageToServer(String? data,
      {double? width, double? height}) async {
    var fileProvider = FileProvider();
    return fileProvider.uploadImage(data, width, height);
  }
}

class InfoAccount extends StatelessWidget {
  final bool isHasDivider;
  final String label;

  final bool isHasEdit;
  final Function? edit;
  final bool enable;
  final List<String> hintText;
  final List<TextEditingController?> controller;
  final List<Function(String value)> validator;

  const InfoAccount(this.label,
      {Key? key,
      this.isHasDivider = true,
      this.isHasEdit = false,
      this.edit,
      this.controller = const [],
      this.validator = const [],
      this.hintText = const [],
      this.enable = true})
      : assert(
            controller.length == validator.length &&
                validator.length == hintText.length &&
                controller.length == hintText.length,
            'length of controller, validator, hintText must length same value '),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          isHasDivider
              ? const SizedBox(
                  height: 20,
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9D9BC9),
                    fontSize: 12),
              ),
              if (isHasEdit)
                GestureDetector(
                  onTap: () {
                    if (edit != null) {
                      edit!();
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return enable
                    ? TextFormFieldLogin(
                        hintText: hintText[index],
                        enable: enable,
                        controller: controller[index],
                        validator: validator[index])
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ColoredBox(
                          color: Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              controller[index]?.text ?? '',
                              style: TextStyle(color: Get.theme.primaryColor),
                            ),
                          ),
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemCount: controller.length)
        ]);
  }
}
