import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:base/models/review.model.dart';
import 'package:base/widgets/dialog.widget.dart';
import 'package:base/widgets/image.list.dart';

import 'review.edit.provider.dart';

class ReviewEditController extends GetxController {
  final ReviewEditProvider provider = ReviewEditProvider();
  final Rx<Review> reviewRoom =
      Review(targetType: ReviewType.room.toShortString()).obs;
  final Rx<Review> reviewBuilding =
      Review(targetType: ReviewType.building.toShortString()).obs;

  final RxList<String> imagesRoomBase64 = <String>[].obs;
  final RxList<File> imagesRoomFile = <File>[].obs;
  final RxList<String> imagesRoomLink = <String>[].obs;

  final RxList<String> imagesBuildingBase64 = <String>[].obs;
  final RxList<File> imagesBuildingFile = <File>[].obs;
  final RxList<String> imagesBuildingLink = <String>[].obs;
  String? contractId;
  String? targetId;
  String? roomID;
  String? buildingID;
  String roomUpdateResponse = '';
  String buildingUpdateResponse = '';

  final Rx<double> ratingRoom = 0.0.obs;
  final Rx<double> ratingBuilding = 0.0.obs;
  final key = GlobalKey<FormState>();

  late TextEditingController reviewRoomController;
  late TextEditingController reviewBuildingController;

  late ImageListController imageRoomController;
  late ImageListController imageBuildingController;

  String? Function(String value) get reviewValidator => (String value) {
        if (value.isEmpty) {
          return 'Hãy nhập gì đấy để comment';
        } else if (value.length > 4000) {
          return 'Chỉ được nhập tối đa 4000 ký tự';
        }
        return null;
      };

  @override
  void onInit() {
    super.onInit();
    reviewRoomController = TextEditingController();
    reviewBuildingController = TextEditingController();
    imageRoomController = ImageListController(
        imagesRoomBase64, imagesRoomFile, imagesRoomLink, 1000);
    imageBuildingController = ImageListController(
        imagesBuildingBase64, imagesBuildingFile, imagesBuildingLink, 1000);
    if (Get.arguments is List && Get.arguments.length > 2) {
      contractId = Get.arguments[0];
      buildingID = Get.arguments[1];
      roomID = Get.arguments[2];
    }
    getReview();
  }

  @override
  void dispose() {
    reviewRoomController.dispose();
    reviewBuildingController.dispose();
    super.dispose();
  }

  void getReview() async {
    var response = await provider.getReview(contractId);
    if (response.isOk &&
        response.body != null &&
        response.body is Map &&
        response.body.isNotEmpty) {
      var roomModel = Review.fromJson(response.body['roomReview']);
      var buildingModel = Review.fromJson(response.body['buildingReview']);

      reviewRoom.value = roomModel;
      // reviewBuilding.value = buildingModel;

      updateData();
    }
    update();
  }

  void editReview() {
    if (roomID != null) {
      if (ratingRoom.value == 0) {
        Get.dialog(CustomFailDialog(
            function: () {
              Get.back();
            },
            title: 'Thông báo',
            description: 'Hãy chọn số sao đánh giá phòng'));
      } else {
        if (ratingRoom.value != 0) {
          updateRatingRoom();
        }
      }
    }
    if (buildingID != null) {
      if (ratingBuilding.value == 0) {
        Get.dialog(CustomFailDialog(
            function: () {
              Get.back();
            },
            title: 'Thông báo',
            description: 'Hãy chọn số sao đánh giá quản lý tòa nhà'));
      } else {
        updateRatingBuilding();
      }
    }
  }

  void updateData() {
    ratingRoom.value = 0.0;
    reviewRoomController.text = '';
    ratingBuilding.value = 0.0;
    reviewBuildingController.text = '';
    imagesRoomLink.clear();
    imagesBuildingLink.clear();
    if (reviewRoom.value.id != null) {
      ratingRoom.value = reviewRoom.value.ratingNumber;
      reviewRoomController.text = reviewRoom.value.content ?? '';
      // ratingBuilding.value = reviewBuilding.value.ratingNumber;
      // reviewBuildingController.text = reviewBuilding.value.content ?? '';
      // imagesBuildingLink.addAll(
      //     reviewBuilding.value.images?.map((e) => e.source ?? '').toList() ??
      //         []);
      imagesRoomLink.addAll(
          reviewRoom.value.images?.map((e) => e.source ?? '').toList() ?? []);
    }
  }

  void updateRatingRoom() async {
    var response = await provider.updateReviewRoom(ratingRoom.value,
        imagesRoomLink, reviewRoomController.text, roomID ?? '');
    if (response.isOk) {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập thành công'));
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập đánh giá xảy ra lỗi ${response.body}'));
    }
  }

  void updateRatingBuilding() async {
    var response = await provider.updateReviewBuilding(ratingBuilding.value,
        imagesBuildingLink, reviewBuildingController.text, buildingID ?? '');
    if (response.isOk) {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập thành công'));
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập đánh giá xảy ra lỗi ${response.body}'));
    }
  }
}
