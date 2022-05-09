import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/home/bloghorizontal/blog.provider.dart';
import 'package:base/models/blog.model.dart';

class BlogDetailController extends GetxController {
  final Rx<Blog> blog = Blog().obs;
  final BlogHorizontalProvider provider = BlogHorizontalProvider();
  final AuthController authController = Get.find(tag: 'authController');
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Blog) {
      blog.value = Get.arguments;
    } else {}
    getBlog();
  }

  void getBlog() async {
    var response = await provider.getOneBlog(blog.value.id ?? '');
    if (response.isOk && response.body != null) {
      var blogModel = Blog.fromJson(response.body['article']);
      blog.value = blogModel;
    }
  }
}
