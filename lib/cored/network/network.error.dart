import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/constants/Image.asset.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';

import 'network.controller.dart';

class NetworkErrorPage extends GetView<NetworkController> {
  const NetworkErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(MyFlutterApp.left_open,
                    color: Color(0xFF797C8D))),
            title: const Text('Thông báo')),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageAsset.pathNoInternet),
                Text(controller.resultNetwork.value.asError?.error.toString() ??
                    ''),
                const SizedBox(
                  height: 16,
                ),
                SmallButton(
                  iconSize: const Size(100, 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  function: () {
                    controller.reloadActivity();
                  },
                  text: 'Tải lại',
                )
              ],
            ),
          ),
        )));
  }
}
