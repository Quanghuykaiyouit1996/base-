import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_admin/unfocus.dart';
import 'package:mobile_admin/utils/helpes/utilities.dart';

import 'app.dart';
import 'config/bindings/app.binding.dart';
import 'config/pages/app.page.dart';
import 'config/themes/theme.base.dart';
import 'cored/auth/auth.controller.dart';
import 'utils/firebase/firemessage.dart';
import 'widgets/loading.widget.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FireMessage.registerFirebase();
  AppBinding().dependencies();
  // var isFirstTime = GetStorage().read('firstTime') ?? true;
  var authController = Get.find<AuthController>(tag: 'authController');
  var hasToken = authController.getHasToken();
  runApp(Unfocuser(
    child: DefaultTextStyle(
      style: const TextStyle(color: Colors.black, fontSize: 14),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            authController.hasToken.value ? Routes.INITIAL : Routes.LOGIN,
        onInit: () async {},
        theme: appThemeData,
        builder: (_, widget) {
          return LoadingWidget(child: widget ?? Container());
        },
        onDispose: () {
          Utilities.streamIsLoading.close();
        },
        routingCallback: (routing) {},
        defaultTransition: Transition.fade,
        initialBinding: AppBinding(),
        getPages: AppPages.pages,
      ),
    ),
  ));
}
