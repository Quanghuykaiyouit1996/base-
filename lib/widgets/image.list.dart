import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_admin/utils/service/file.service.dart';
import 'package:mobile_admin/widgets/dialog.widget.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom.list.dart';

class ImageList extends StatelessWidget {
  final bool justShow;
  final TypeImageList type;
  final ImageListController controller;

  const ImageList({
    Key? key,
    required this.controller,
    this.justShow = false,
    this.type = TypeImageList.wrap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: GetBuilder<ImageListController>(
          init: controller,
          initState: (_) {},
          id: 'imageListController',
          builder: (_) {
            switch (type) {
              case TypeImageList.scrollhorizontal:
                return ScrollHorizontalImage(justShow, controller);
              default:
                return WrapImage(justShow, controller);
            }
          },
        ));
  }
}

class ScrollHorizontalImage extends StatelessWidget {
  final bool justShow;
  final ImageListController controller;
  const ScrollHorizontalImage(this.justShow, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 80,
          child: CustomList(
            itemCount: controller.imagesLink.length,
            scrollDirection: Axis.horizontal,
            mainSpace: 8,
            customWidget: (index) {
              var element = controller.imagesLink[index];
              return Stack(
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        element,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      )),
                  if (!justShow)
                    Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                            onTap: () {
                              controller.deleteItem(element);
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, top: 5.0),
                              child: Transform.rotate(
                                angle: pi / 4,
                                child: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 15,
                                ),
                              ),
                            )))
                ],
              );
            },
          ),
        ));
  }
}

class WrapImage extends StatelessWidget {
  final bool justShow;
  final ImageListController controller;
  const WrapImage(this.justShow, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          spacing: 4,
          runSpacing: 4,
          direction: Axis.horizontal,
          children: [
            ...controller.imagesLink
                .map((element) => Stack(
                      children: [
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              element,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            )),
                        if (!justShow)
                          Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.deleteItem(element);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, top: 5.0),
                                    child: Transform.rotate(
                                      angle: pi / 4,
                                      child: const Icon(
                                        Icons.add_circle_outline_sharp,
                                        size: 15,
                                      ),
                                    ),
                                  )))
                      ],
                    ))
                .toList(),
            if (!justShow)
              SizedBox(
                width: 80,
                height: 80,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.uploadImage(true, context);
                  },
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      strokeWidth: 1,
                      dashPattern: const [6, 5],
                      strokeCap: StrokeCap.butt,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Get.theme.primaryColor,
                                size: 80 * 2 / 5,
                              ),
                              Text('Thêm ảnh')
                            ],
                          ),
                        ),
                      )),
                ),
              )
          ],
        ));
  }
}

class ImageListController extends GetxController {
  final RxList<String> imagesBase64;
  final RxList<File> imagesFile;
  final RxList<String> imagesLink;
  final int countImage;
  DropzoneViewController? controller;
  int maxFileSize = 5242880;
  final picker = ImagePicker();

  ImageListController(
      this.imagesBase64, this.imagesFile, this.imagesLink, this.countImage);

  void uploadImage(bool isFront, BuildContext context1) {
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
                    var pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
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
                    var pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
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
    var base64 = convertImageFileToBase64(image);
    var response = await uploadImageToServer(base64);
    if (response.isOk && response.body != null) {
      imagesLink.add(response.body['image']['publicUrl']);
      imagesLink.refresh();
      update(['imageListController']);
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'không tải được lên hình ảnh'));
    }
    update(['imageListController']);
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

  void deleteItem(String element) {
    imagesLink.remove(element);
    imagesLink.refresh();
    update(['imageListController']);
  }
}

enum TypeImageList { scrollvertical, scrollhorizontal, wrap }
