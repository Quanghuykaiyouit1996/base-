import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:base/models/review.model.dart';

import 'review.provider.dart';

class ReviewController extends GetxController {
  final RxList<Review> reviews = <Review>[].obs;
  final Rx<ReviewType> typeList = (ReviewType.room).obs;
  final ReviewProvider provider = ReviewProvider();
  ScrollController scrollController = ScrollController();

  bool isFull = false;
  bool isLoadMore = false;
  @override
  void onInit() {
    super.onInit();
    getReviews();
    scrollController.addListener(_scrollListener);
    typeList.stream.listen((event) {
      getReviews();
    });
  }

  void _scrollListener() {
    if ((scrollController.position.extentAfter) < 100 &&
        (scrollController.position.extentBefore) > 0) {
      loadMore();
    }
  }

  void loadMore() async {
    if (!isLoadMore && !isFull) {
      isLoadMore = true;
      var response = await provider.getReview(typeList.value,
          skip: reviews.length, take: 20);
      if (response.hasError) {
        // branches.clear();
      } else {
        var reviewModel = ReviewModel.fromJson(response.body);
        if ((reviewModel.reviewes?.length ?? 0) == 0) {
          isFull = true;
        } else {
          reviews.addAll(reviewModel.reviewes ?? []);
        }
      }
      isLoadMore = false;
    }
  }

  void getReviews() async {
    var response = await provider.getReview(typeList.value);
    reviews.clear();
    try {
      scrollController.jumpTo(0);
    } catch (e) {}
    if (response.isOk && response.body != null) {
      var reviewModel = ReviewModel.fromJson(response.body);
      reviews.addAll(reviewModel.reviewes ?? []);
    }

    isFull = false;
    isLoadMore = false;
  }

  void changeTab(int index) {
    if (index == 0) {
      typeList.value = ReviewType.room;
    } else {
      typeList.value = ReviewType.building;
    }
    getReviews();
  }
}

enum TypeListContract { validate, unvalidate }
