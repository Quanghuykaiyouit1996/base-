import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:base/models/review.model.dart';
import 'package:base/widgets/dialog.widget.dart';
import 'package:base/widgets/image.list.dart';

import 'review.detail.provider.dart';

class ReviewDetailController extends GetxController {
  final ReviewDetailProvider provider = ReviewDetailProvider();
  final Rx<Review> review = Review().obs;
  String? reviewId;
  final RxList<String> imagesBase64 = <String>[].obs;
  final RxList<File> imagesFile = <File>[].obs;
  final RxList<String> imagesLink = <String>[].obs;
  final key = GlobalKey<FormState>();

  String? Function(String value) get reviewValidator => (String value) {
        if (value.isEmpty) {
          return 'Hãy nhập gì đấy để comment';
        } else if (value.length > 4000) {
          return 'Chỉ được nhập tối đa 4000 ký tự';
        }
        return null;
      };

  final Rx<double> rating = 0.0.obs;

  late TextEditingController reviewController;

  late ImageListController imageController;
  @override
  void onInit() {
    super.onInit();
    reviewController = TextEditingController();
    imageController =
        ImageListController(imagesBase64, imagesFile, imagesLink, 1000);
    reviewId = Get.arguments;
    getReview();
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void getReview() async {
    var response = await provider.getReview(reviewId);

    if (response.isOk && response.body != null) {
      var roomModel = Review.fromJson(response.body['review']);

      review.value = roomModel;
      updateData();
    }
    update();
  }

  void editReview() async {
    var response = await provider.editReview(
        reviewId, rating.value, imagesLink, reviewController.text);
    if (response.isOk) {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập thành công'));
    } else {
      Get.dialog(CustomSuccessDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: 'Cập nhập thất bại \n ${response.body}'));
    }
  }

  void updateData() {
    rating.value = 0.0;
    reviewController.text = '';
    imagesLink.clear();
    if (review.value.id != null) {
      rating.value = review.value.ratingNumber;
      reviewController.text = review.value.content ?? '';
      imagesLink.addAll(
          review.value.images?.map((e) => e.source ?? '').toList() ?? []);
    }
  }
}
