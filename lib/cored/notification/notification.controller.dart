import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:base/models/notification.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'notification.provider.dart';

class NotificationController extends GetxController {
  final RxList<NotificationData> notifications = <NotificationData>[].obs;
  final Rx<TypeListNotification> typeList = (TypeListNotification.all).obs;
  final RxList<String> listSeenNotification = <String>[].obs;
  final NotificationProvider provider = NotificationProvider();
  final Rx<int> totalCount = 0.obs;
  bool isFull = false;
  bool isLoadMore = false;

  int get totalUnseenCount => totalCount.value;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
    getCountUnseenNotification();
    scrollController = ScrollController()..addListener(_scrollListener);
    typeList.stream.listen((event) {
      getNotifications();
    });
    getAllSeenNotification();
  }

  void _scrollListener() {
    if ((scrollController.position.extentAfter) < 100 &&
        (scrollController.position.extentBefore) > 0) {
      loadMore();
    }
  }

  void loadMore() async {
    if (!isLoadMore && !isFull) {
      isLoadMore = true;
      var response = await provider.getNotification(
        typeList.value,
        skip: notifications.length,
        take: 20,
      );
      if (response.hasError) {
        // branches.clear();
      } else {
        var orderResponse = NotificationModel.fromJson(response.body);
        if ((orderResponse.notifications?.length ?? 0) == 0) {
          isFull = true;
        } else {
          notifications.addAll(orderResponse.notifications!);
        }
      }
      isLoadMore = false;
    }
  }

  void getNotifications() async {
    var response = await provider.getNotification(
      typeList.value,
      skip: 0,
      take: 20,
    );
    notifications.clear();
    if (response.isOk && response.body != null) {
      var contractModel = NotificationModel.fromJson(response.body);
      notifications.addAll(contractModel.notifications ?? []);
    }
    isLoadMore = false;
    isFull = false;
    getCountUnseenNotification();
  }

  void changeTab(int index) {
    if (index == 0) {
      typeList.value = TypeListNotification.all;
    } else {
      typeList.value = TypeListNotification.mine;
    }
    getNotifications();
    getAllSeenNotification();
  }

  void getCountUnseenNotification() async {
    var totalNotification = 0;
    var response = await provider.getNotification(
      TypeListNotification.all,
      skip: notifications.length,
      take: 20,
    );
    if (response.isOk && response.body != null) {
      var contractModel = NotificationModel.fromJson(response.body);
      totalNotification = totalNotification + (contractModel.total ?? 0);
    }
    var response1 = await provider.getNotification(
      TypeListNotification.mine,
      skip: notifications.length,
      take: 20,
    );
    if (response1.isOk && response1.body != null) {
      var contractModel = NotificationModel.fromJson(response1.body);
      totalNotification = totalNotification + (contractModel.total ?? 0);
    }
    totalCount.value = 0;
    var countSeen = 0;
    var listNotificationSeen = GetStorage().read('listNotificationSeen');
    if (listNotificationSeen != null) {
      if (jsonDecode(listNotificationSeen) is Map<String, dynamic>) {
        var listTemp =
            NotificationSeenModel.fromJson(jsonDecode(listNotificationSeen));
        countSeen = countSeen + (listTemp.notificationId?.length ?? 0);
      }
    }
    var listNotificationSeenMine =
        GetStorage().read('listNotificationSeenMine');
    if (listNotificationSeenMine != null) {
      if (jsonDecode(listNotificationSeenMine) is Map<String, dynamic>) {
        var listTemp = NotificationSeenModel.fromJson(
            jsonDecode(listNotificationSeenMine));
        countSeen = countSeen + (listTemp.notificationId?.length ?? 0);
      }
    }
    if (totalNotification > countSeen) {
      totalCount.value = totalNotification - countSeen;
    }
    FlutterAppBadger.updateBadgeCount(totalCount.value);
  }

  void getAllSeenNotification() {
    listSeenNotification.clear();
    if (typeList.value == TypeListNotification.all) {
      var response = GetStorage().read('listNotificationSeen');
      if (response != null) {
        if (jsonDecode(response) is Map<String, dynamic>) {
          var listTemp = NotificationSeenModel.fromJson(jsonDecode(response));
          listSeenNotification.addAll(listTemp.notificationId ?? []);
        }
      }
    } else {
      var response = GetStorage().read('listNotificationSeenMine');
      if (response != null) {
        if (jsonDecode(response) is Map<String, dynamic>) {
          var listTemp = NotificationSeenModel.fromJson(jsonDecode(response));
          listSeenNotification.addAll(listTemp.notificationId ?? []);
        }
      }
    }
    update(['seen']);
  }

  void checkAll() async {
    if (!isFull) {
      await getAllNotification();
    }
    if (typeList.value == TypeListNotification.all) {
      GetStorage().write(
          'listNotificationSeen',
          jsonEncode(NotificationSeenModel(
                  notificationId:
                      notifications.map((element) => element.id ?? '').toList())
              .toJson()));
    } else {
      GetStorage().write(
          'listNotificationSeenMine',
          jsonEncode(NotificationSeenModel(
                  notificationId:
                      notifications.map((element) => element.id ?? '').toList())
              .toJson()));
    }
    listSeenNotification.clear();
    listSeenNotification
        .addAll(notifications.map((element) => element.id ?? ''));
    getCountUnseenNotification();
    update(['seen']);
  }

  Future<void> getAllNotification() async {
    var response = await provider.getNotification(
      typeList.value,
      skip: 0,
      take: 20,
    );
    notifications.clear();
    if (response.isOk && response.body != null) {
      var contractModel = NotificationModel.fromJson(response.body);
      notifications.addAll(contractModel.notifications ?? []);
      if (notifications.length < (contractModel.total ?? 0)) {
        await getMoreNotification();
      }
    }
    isLoadMore = false;
    isFull = true;
  }

  Future<void> getMoreNotification() async {
    var response = await provider.getNotification(
      typeList.value,
      skip: notifications.length,
      take: 20,
    );
    if (response.isOk && response.body != null) {
      var contractModel = NotificationModel.fromJson(response.body);
      notifications.addAll(contractModel.notifications ?? []);
      if (notifications.length < (contractModel.total ?? 0)) {
        await getMoreNotification();
      }
    }
  }

  bool isSeen(String? id) {
    return listSeenNotification.any((element) => element == id);
  }

  void seen(NotificationData notification) {
    if (notification.id != null) {
      if (!listSeenNotification.any((element) => element == notification.id)) {
        listSeenNotification.add(notification.id!);
        totalCount.value = totalCount.value - 1;
        if (typeList.value == TypeListNotification.all) {
          GetStorage().write(
              'listNotificationSeen',
              jsonEncode(
                  NotificationSeenModel(notificationId: listSeenNotification)
                      .toJson()));
        } else {
          GetStorage().write(
              'listNotificationSeenMine',
              jsonEncode(
                  NotificationSeenModel(notificationId: listSeenNotification)
                      .toJson()));
        }
        update(['seen']);
      }
      Utilities.goToPage(notification);
    }
  }
}

enum TypeListNotification { all, mine }

class NotificationSeenModel {
  List<String>? notificationId;

  NotificationSeenModel({this.notificationId});

  NotificationSeenModel.fromJson(Map<String, dynamic> json) {
    if (json['notificationId'] != null) {
      notificationId = <String>[];
      json['notificationId'].forEach((v) {
        notificationId!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationId != null) {
      data['notificationId'] = notificationId?.map((v) => v).toList() ?? [];
    }
    return data;
  }
}
