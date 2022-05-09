import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  late PageController pageController;
  int pageCurrent = 0;
  Rx<bool> isScrolling = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ScrollController controllerScroll;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    controllerScroll = ScrollController();
    controllerScroll.addListener(() {
      scrollListener();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    controllerScroll.dispose();
    super.dispose();
}

  void scrollListener() {
    if (controllerScroll.position.extentBefore > 30) {
      if (!isScrolling.value) {
        isScrolling.value = true;
      }
    } else {
      if (isScrolling.value) {
        isScrolling.value = false;
      }
    }
  }

  void navigateToPage(int i) {
    pageCurrent = i;
    pageController.jumpToPage(i);
    update(['bottomBar']);
  }
}
