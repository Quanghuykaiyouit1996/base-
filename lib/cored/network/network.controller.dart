import 'dart:async';

import 'package:async/async.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Rx<Result<ConnectivityResult>> resultNetwork =
      Result<ConnectivityResult>.error(
              'Không có kết nối mạng, hãy kết nối lại mạng')
          .obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initConnectivity() async {
    var result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    updateConnectionStatus(result);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void reloadActivity() async {
    var result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    updateConnectionStatus(result);
  }

  void updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        resultNetwork.value = Result.value(ConnectivityResult.wifi);
        break;
      case ConnectivityResult.mobile:
        resultNetwork.value = Result.value(ConnectivityResult.mobile);
        break;
      case ConnectivityResult.none:
        resultNetwork.value =
            Result.error('Không có kết nối mạng, hãy kết nối lại mạng');
        break;
      default:
        resultNetwork.value = Result.error('Không có kết nối mạng');
        break;
    }
  }
}
