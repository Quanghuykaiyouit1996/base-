import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/room.model.dart';

import 'room.provider.dart';

class RoomController extends GetxController {
  final RxList<Room> rooms = <Room>[].obs;
  final RoomProvider provider = RoomProvider();
  bool isFull = false;
  bool isLoadMore = false;
  ScrollController? controller;
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    controller = ScrollController()..addListener(_scrollListener);
    getRooms();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if ((controller?.position.extentAfter ?? 0) < 100 &&
        (controller?.position.extentBefore ?? 0) > 0) {
      loadMore();
    }
  }

  void loadMore() async {
    if (!isLoadMore && !isFull) {
      isLoadMore = true;
      var response = await provider.getRooms(
        skip: rooms.length,
        take: 20,
      );
      if (response.hasError) {
        // branches.clear();
      } else {
        var blogModel = RoomModel.fromJson(response.body);
        if ((blogModel.rooms?.length ?? 0) == 0) {
          isFull = true;
        } else {
          rooms.addAll(blogModel.rooms ?? []);
        }
      }
      isLoadMore = false;
    }
  }

  void getRooms() async {
    var response = await provider.getRooms(skip: 0, take: 20);
    rooms.clear();
    if (response.isOk && response.body != null) {
      var roomModel = RoomModel.fromJson(response.body);
      rooms.addAll(roomModel.rooms ?? []);
    }
  }
}

enum TypeListContract { validate, unvalidate }
