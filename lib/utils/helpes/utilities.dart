import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:mobile_admin/app.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import 'package:mobile_admin/cored/home/home.controller.dart';
import 'package:mobile_admin/models/address.model.dart';
import 'package:mobile_admin/models/blog.model.dart';
import 'package:mobile_admin/models/contract.model.dart';
import 'package:mobile_admin/models/notification.model.dart';
import 'package:mobile_admin/models/settings.model.dart';
import 'package:rxdart/rxdart.dart';

import '../../app.controller.dart';
import '../../config/pages/app.page.dart';
import '../../constants/Image.asset.dart';

import 'package:transparent_image/transparent_image.dart';

class Utilities {
  static Widget getImageNetworkNoCache(String imageUrl, {BoxFit? fit}) {
    return Image.network(
      imageUrl,
      fit: fit ?? BoxFit.fill,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          ImageAsset.pathPlaceHolder,
          fit: BoxFit.cover,
        );
      },
    );
  }

  static Widget getImageNetwork(String? imageUrl, {BoxFit? fit}) {
    try {
      if (imageUrl != null && imageUrl != '') {
        return CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                Image(image: MemoryImage(kTransparentImage)),
            errorWidget: (context, imageProvider, _) =>
                getImageNetworkNoCache(imageUrl),
            imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: fit ?? BoxFit.cover))));
      } else {
        return Image(
            fit: fit ?? BoxFit.cover,
            image: AssetImage(
              ImageAsset.pathPlaceHolder,
            ));
      }
    } catch (e) {
      return FadeInImage(
          fadeInDuration: Duration(milliseconds: 100),
          fadeOutDuration: Duration(milliseconds: 100),
          fit: fit ?? BoxFit.cover,
          placeholder: AssetImage(
            ImageAsset.pathPlaceHolder,
          ),
          image: ((imageUrl != null && imageUrl != '')
              ? NetworkImage(imageUrl)
              : AssetImage(
                  ImageAsset.pathPlaceHolder,
                )) as ImageProvider<Object>);
    }
  }

  static String setProfileImageFileName(String strSpecial) {
    return 'profile_img_$strSpecial';
  }

  static String convertImageFileToBase64(File image) {
    String base64Image;
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static BehaviorSubject<bool> streamIsLoading = BehaviorSubject<bool>();
  static int countLoading = 0;

  static String getAddress(AddressModel? address) {
    var list = <String?>[];
    if (address?.address1?.isNotEmpty ?? false) list.add(address?.address1);
    if (address?.ward != null) {
      list.add(address?.ward?.name);
    }
    if (address?.district != null) {
      list.add(address?.district?.name);
    }
    if (address?.city != null) list.add(address?.city?.name);
    if (list.isEmpty) return '';
    return list.join(', ');
  }

  static void goToPageFromPopup() {}

  static void goToPageFromBanner(ItemModule itemModule) {
    if (itemModule.type == 'blog') {
      Get.toNamed(Routes.BLOG, arguments: itemModule.value);
    }
  }

  static Widget getTextHasBoldInline(String text, Color color) {
    var parts = _splitJoin(text);
    if (text.isEmpty) {
      return Container();
    }
    return Text.rich(TextSpan(
        children: parts
            .map((e) => TextSpan(
                text: e.text,
                style: (e.isBold)
                    ? TextStyle(fontWeight: FontWeight.w700, color: color)
                    : const TextStyle()))
            .toList()));
  }

  static List<TextPart> _splitJoin(text) {
    if (text == null) {
      return [];
    }

    final tmp = <TextPart>[];

    final parts = text.split('***');

    for (var i = 0; i < parts.length; i++) {
      if (i % 2 != 0) {
        tmp.add(TextPart(parts[i], true));
      } else {
        tmp.add(TextPart(parts[i], false));
      }
    }

    return tmp;
  }

  static Timer? timer;
  static int timeTimeOut = 30;

  static String checkNullStringHaveUnit(String? text, String unit) {
    return text == null ? '' : '$text $unit';
  }

  static void updateLoading(bool isLoading, {int timeTimeOut = 20}) {
    timeTimeOut = timeTimeOut;
    if (isLoading) {
      countLoading = countLoading + 1;
    } else {
      countLoading = countLoading - 1;
    }
    if (countLoading <= 0) {
      countLoading = 0;
    }
    if (countLoading == 0) {
      streamIsLoading.sink.add(false);
      timer?.cancel();
      timer = null;
    } else {
      streamIsLoading.sink.add(true);
      timer ??= Timer(Duration(seconds: timeTimeOut), () {
        countLoading = 0;
        streamIsLoading.sink.add(false);
      });
    }
  }

  static void goToHomePage() {
    // while (Get.currentRoute != Routes.INITIAL) {
    Get.back();
    // }
  }

  static void goToPage(dynamic pageToGo) {
    if (pageToGo is String) {
      if (pageToGo == Routes.PROFILE) {
        Get.toNamed(Routes.PROFILE);
        return;
      }
    }
    if (pageToGo is NotificationData) {
      if (pageToGo.payload?.data?.screen == null) {
        if (pageToGo.payload?.data?.targetObject == 'order') {
          // Get.toNamed(Routes.CONTRACTDETAIL,
          //     arguments: Contracts(id: pageToGo.payload?.data?.id));
          // return;
        } else if (pageToGo.payload?.data?.targetObject == 'contract') {
          Get.toNamed(Routes.CONTRACTDETAIL,
              arguments: pageToGo.payload?.data?.id);
          return;
        } else if (pageToGo.payload?.data?.targetObject == 'invoice') {
          Get.toNamed(Routes.INVOICEDETAIL,
              arguments: pageToGo.payload?.data?.id);
        }
      } else {
        if (pageToGo.payload?.data?.screen == 'other') {
          Get.toNamed(Routes.WEBVIEWPAGE,
              arguments: pageToGo.payload?.data?.url);
          return;
        }
        if ((pageToGo.payload?.data?.screen?.contains(Routes.BLOG) ?? false)) {
          var list = pageToGo.payload?.data?.screen?.split('/') ?? [];
          if (list.length == 3) {
            Get.toNamed(Routes.BLOG, arguments: list[2]);
            return;
          } else {
            Get.toNamed(Routes.BLOG);
            return;
          }
        }
        if ((pageToGo.payload?.data?.screen?.contains('/') ?? false) &&
            pageToGo.payload?.data?.screen != '/home') {
          Get.toNamed(pageToGo.payload?.data?.screen ?? '/');
          return;
        } else {
          Get.until((route) => Get.currentRoute == Routes.INITIAL);

          try {
            var appController = Get.find<AppController>();
            appController.navigateToPage(0);
          } on Exception catch (e) {}
          return;
        }
      }
    }
    Get.until((route) => Get.currentRoute == Routes.INITIAL);
  }

  static void showImage(String? source) {
    Get.dialog(
        Center(
          child: SizedBox(
              height: 400,
              child: getImageNetwork(source ?? '', fit: BoxFit.contain)),
        ),
        barrierDismissible: true);
  }

  static stringHasSuffix(String? text, String suffix) {
    if (text == null || text.isEmpty) {
      return '';
    }
    return '$text$suffix';
  }

  static String getRatingComment(double value) {
    if (value == 1) {
      return 'Tệ';
    } else if (value == 2) {
      return 'Tạm chấp nhận';
    } else if (value == 3) {
      return 'Bình thường';
    } else if (value == 4) {
      return 'Tốt';
    } else if (value == 5) {
      return 'Cực kỳ hài lòng';
    }
    return '';
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text ?? '').documentElement?.text ?? '';

    return parsedString;
  }
}

class TextPart {
  String? text;
  bool isBold;

  TextPart(this.text, this.isBold);
}
