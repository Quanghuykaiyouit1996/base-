import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/home/bloghorizontal/blog.provider.dart';
import 'package:base/models/blog.model.dart';

class BlogController extends GetxController {
  final RxList<Blog> blogs = <Blog>[].obs;
  final RxString title = 'Tất cả bài viết'.obs;
  bool isFull = false;
  bool isLoadMore = false;
  ScrollController? controller;
  String? idGroup;
  final BlogHorizontalProvider provider = BlogHorizontalProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    controller = ScrollController()..addListener(_scrollListener);
    if (Get.arguments is String) {
      idGroup = Get.arguments;
    }
    getBlog();
  }

  void _scrollListener() {
    if ((controller?.position.extentAfter ?? 0) < 100 &&
        (controller?.position.extentBefore ?? 0) > 0) {
      loadMore();
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void getBlog() async {
    blogs.clear();

    var response =
        await provider.getBlog(skip: 0, take: 40, blogGroup: idGroup);
    if (response.isOk && response.body != null) {
      var blogModel = BlogModel.fromJson(response.body);
      blogs.addAll(blogModel.results ?? []);
    }

    isFull = false;
    isLoadMore = false;
  }

  void loadMore() async {
    if (!isLoadMore && !isFull) {
      isLoadMore = true;
      var response = await provider.getBlog(
          skip: blogs.length, take: 20, blogGroup: idGroup);
      if (response.hasError) {
        // branches.clear();
      } else {
        var blogModel = BlogModel.fromJson(response.body);
        if ((blogModel.results?.length ?? 0) == 0) {
          isFull = true;
        } else {
          blogs.addAll(blogModel.results ?? []);
        }
      }
      isLoadMore = false;
    }
  }
}

enum BlogType { blogpost, blogs, all }
