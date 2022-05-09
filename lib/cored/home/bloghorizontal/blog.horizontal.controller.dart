import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/blog.model.dart';
import 'package:base/models/settings.model.dart';

import 'blog.provider.dart';

class BlogHorizontalController extends GetxController {
  final RxList<Blog> blogs = <Blog>[].obs;
  final BlogHorizontalProvider provider = BlogHorizontalProvider();
  final AuthController authController = Get.find(tag: 'authController');
  ItemModule? itemModule;
  String? idBlogGroup;

  BlogHorizontalController(ItemModule? item) {
    if (item?.value != null && idBlogGroup == null) {
      itemModule = item;
      idBlogGroup = item!.value;
      getBlog();
    }
  }
  @override
  void onInit() {
    super.onInit();
    getBlog();
  }

  void getBlog() async {
    if (idBlogGroup == null) {
      return;
    }
    var response =
        await provider.getBlog(skip: 0, take: 4, blogGroup: idBlogGroup);
    blogs.clear();
    if (response.isOk && response.body != null) {
      var blogModel = BlogModel.fromJson(response.body);

      blogs.addAll(blogModel.results ?? []);
    }
  }

  void viewAll() {
    Get.toNamed(Routes.BLOG, arguments: idBlogGroup);
  }
}
