import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:base/app.controller.dart';
import 'package:base/models/auth.model.dart';
import 'package:base/models/user.model.dart';
import 'package:base/utils/firebase/firemessage.dart';

import '../../config/pages/app.page.dart';
import '../../utils/helpes/utilities.dart';
import '../../widgets/dialog.widget.dart';

import 'auth.provider.dart';

class AuthController extends GetxController {
  var hasToken = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId1;
  late PhoneAuthCredential _credential;
  final AuthProvider provider = AuthProvider();
  AuthResponseModel authResponse = AuthResponseModel();
  UserModel get user => _user.value;
  final Rx<UserModel> _user = UserModel().obs;
  String _phoneNumber = '';

  RxString avatar = ''.obs;

  Map<String, String> get getHeader => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authResponse.accessToken}',
        'X-Suplo-Shop-Id': '017c691c-b991-f95a-07f2-62da5b63ab07'
      };

  @override
  void onInit() {
    getHasToken();
    super.onInit();
    if (hasToken.value) {
      getUserInfo();
    }
  }

  void updateToken() {
    hasToken.value = !hasToken.value;
  }

  void saveToken(AuthResponseModel tempCurrentUser, bool isLogin) {
    GetStorage().write('user', tempCurrentUser.toJson());
    if (isLogin) {
      authResponse = tempCurrentUser;
      updateToken();
      getUserInfo();
    } else {
      hasToken.value = false;
    }
  }

  void removeToken() async {
    Utilities.updateLoading(true);
    await provider.logOut(getHeader);
    await GetStorage().write('user', null);
    _user.value = UserModel();
    goToLoginPage();
    updateToken();
    Utilities.updateLoading(false);
  }

  void getHasToken() {
    var prefsUser = GetStorage().read('user');
    if (prefsUser != null) {
      var tempToken = prefsUser;
      var tempCurrentUser = AuthResponseModel.fromJson(tempToken ?? {});
      authResponse = tempCurrentUser;
      if (tempCurrentUser.accessToken != null) {
        hasToken.value = true;
        return;
      }
    }
    hasToken.value = false;
  }

  String getToken() {
    var prefsUser = GetStorage().read('user');
    if (prefsUser != null) {
      var tempToken = prefsUser;
      var tempCurrentUser = AuthResponseModel.fromJson(tempToken ?? {});
      if (tempCurrentUser.accessToken != null) {
        return tempCurrentUser.accessToken ?? '';
      }
    }
    return '';
  }

  int maxFileSize = 5242880;

  Future<void> verify(String? phoneNumber) async {
    _phoneNumber = phoneNumber ?? '';
    Utilities.updateLoading(true);
    await _auth
        .verifyPhoneNumber(
          phoneNumber:
              '+84${phoneNumber?.substring(1, phoneNumber.length) ?? ''}',
          timeout: const Duration(seconds: 30),
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId1 = verificationId;
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            verificationId1 = verificationId;
            Utilities.updateLoading(false);
            if (Get.currentRoute == Routes.OTP) {
              if (!(Get.isSnackbarOpen ?? false)) {
                Get.rawSnackbar(
                  borderRadius: 4.0,
                  duration: const Duration(seconds: 5),
                  overlayColor: Colors.blue,
                  margin: const EdgeInsets.all(16.0),
                  messageText: Text('OTP đã được gửi đi, hãy kiên nhẫn chờ đợi',
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w700)),
                  backgroundColor: const Color(0x1AE84A4D),
                );
              }
            } else {
              Get.toNamed(Routes.OTP, arguments: _phoneNumber);
            }
          },
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException error) {
            Utilities.updateLoading(false);
            if (error.code == 'too-many-requests') {
              Get.dialog(CustomFailDialog(
                function: () {
                  Get.back();
                },
                title: 'Thông báo',
                description:
                    'Số điện thoại của bạn đã bị chặn vì gửi yêu cầu quá nhiều',
              ));
            }
          },
        )
        .catchError((e) {});
  }

  void getUserInfo() async {
    var response = await provider.getUserInfo(getHeader);
    if (response.isOk || response.body != null) {
      FireMessage.registerToken('Bearer ${authResponse.accessToken}');
      _user.value = UserModel.fromJson(response.body['customer']);

      avatar.value = _user.value.photoUrl ?? '';
    } else {
      Get.rawSnackbar(message: 'get user Failed');
      // _user.value = UserModel();
      // avatar.value = '';
      // await GetStorage().write('user', null);
      // hasToken.value = false;
    }
  }

  void resetOTP() {
    if (_phoneNumber.isNotEmpty) {
      verify(_phoneNumber);
    }
  }

  void login(String email, String password) async {
    var response = await provider.logIn(email, password);
    if (response.isOk && response.body != null) {
      var authResponseModel = AuthResponseModel.fromJson(response.body);
      saveToken(authResponseModel, true);
      Get.back();
      Get.toNamed(Routes.INITIAL);
      try {
        var appController = Get.find<AppController>();
        appController.navigateToPage(0);
      } catch (e) {
        e.printError();
      }
    } else {
      Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description: response.body['message']));
    }
  }

  void goToLoginPage() {
    Get.until((route) => Get.currentRoute == Routes.INITIAL);
    Get.offNamed(Routes.LOGIN);
  }

  void confirmOtp(String otp) {
    Utilities.updateLoading(true);
    _credential = PhoneAuthProvider.credential(
        verificationId: verificationId1, smsCode: otp);
    _auth.signInWithCredential(_credential).then((UserCredential result) async {
      exChangeToken(await result.user?.getIdToken());
    }).catchError((e) {
      Utilities.updateLoading(false);
      if (e.code == 'invalid-verification-code') {
        Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description:
              'Mã OTP không chính xác , hãy nhập mã được gửi về số $_phoneNumber',
        ));
      } else if (e.code == 'missing-verification-code') {
        Get.dialog(CustomFailDialog(
          function: () {
            Get.back();
          },
          title: 'Thông báo',
          description:
              'Thiếu mã OTP , hãy nhập mã được gửi về số $_phoneNumber',
        ));
      } else {
        Get.back();
        Get.rawSnackbar(
            borderRadius: 4.0,
            duration: const Duration(seconds: 5),
            margin: EdgeInsets.fromLTRB(
                16.0,
                0,
                16.0,
                (Get.currentRoute == Routes.INITIAL
                    ? kToolbarHeight * 3 / 2
                    : 16.0)),
            messageText: Text('Tài khoản của quý khách không đúng',
                style: Get.textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.w700)),
            backgroundColor: Colors.red,
            icon: Transform.rotate(
                angle: math.pi / 4,
                child: const Icon(
                  Icons.add_circle,
                  color: Colors.red,
                )));
      }
    });
  }

  void exChangeToken(String? token) async {
    var response = await provider.exChangeToken(token);
    Utilities.updateLoading(false);

    if (response.hasError || response.body == null) {
      Get.rawSnackbar(
          borderRadius: 4.0,
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.all(16.0),
          messageText: Text(
              'Tài khoản của quý khách không đúng hoặc chưa được quản trị viên phê duyệt.',
              style: Get.textTheme.bodyText2!
                  .copyWith(fontWeight: FontWeight.w700)),
          backgroundColor: Colors.red,
          icon: Transform.rotate(
              angle: math.pi / 4,
              child: const Icon(
                Icons.add_circle,
                color: Colors.red,
              )));
    } else {
      var authResponseModel = AuthResponseModel.fromJson(response.body);
      saveToken(authResponseModel, true);
      Get.offAndToNamed(Routes.INITIAL);
    }
  }

  Future<Response> updateUser(
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
      String bankName) async {
    var response = await provider.updateUser(
        phoneNUmber,
        photoUrl,
        name,
        dob,
        gender,
        ssn,
        sscImageFront,
        sscImageBack,
        bankAccountNumber,
        bankOwnerName,
        bankName,
        getHeader);
    return response;
  }
}
