import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/models/review.model.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class ReviewProvider extends MyConnect {
  ReviewProvider();

  AuthController authController = Get.find(tag: 'authController');

  getReview(ReviewType value, {int? skip, int? take}) {}
}
