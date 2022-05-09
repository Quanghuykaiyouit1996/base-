import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/blog.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class BlogHorizontalProvider extends MyConnect {
  BlogHorizontalProvider();

  AuthController authController = Get.find(tag: 'authController');

  getBlog({int? skip, int? take, String? blogGroup}) {}

  getOneBlog(String s) {}
}
