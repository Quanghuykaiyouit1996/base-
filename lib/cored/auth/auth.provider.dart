import 'package:get/get.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/service/my.connect.dart';
import '../../utils/helpes/constant.dart';

class AuthProvider extends MyConnect {
  exChangeToken(String? token) {}

  updateUser(
      String phoneNUmber,
      String photoUrl,
      String name,
      String dob,
      String gender,
      String ssn,
      String sscImageFront,
      String sscImageBack,
      String bankAccountNumber,
      String bankOwnerName,
      String bankName,
      Map<String, String> getHeader) {}

  logIn(String email, String password) {}

  getUserInfo(Map<String, String> getHeader) {}

  logOut(Map<String, String> getHeader) {}
}
