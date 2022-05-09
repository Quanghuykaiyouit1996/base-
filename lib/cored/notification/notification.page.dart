import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/models/notification.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/decorate.bottom.appbar.dart';

import 'notification.controller.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  NotificationController get controller =>
      Get.find<NotificationController>(tag: 'notificationController');
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.getAllSeenNotification();
        return true;
      },
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('Quản lý thông báo'),
                actions: [
                  GestureDetector(
                    onTap: () {
                      controller.checkAll();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        MyFlutterApp.check,
                        color: Get.theme.primaryColorDark,
                      ),
                    ),
                  )
                ],
                titleSpacing: 0,
                bottom: DecoratedTabBar(
                  tabBar: DefaultTabController(
                    length: 2,
                    initialIndex:
                        controller.typeList.value == TypeListNotification.all
                            ? 0
                            : 1,
                    child: TabBar(
                      onTap: (index) {
                        controller.changeTab(index);
                      },
                      unselectedLabelColor:
                          const Color(0xFF9D9BC9).withOpacity(0.5),
                      indicatorWeight: 2.0,
                      labelPadding: EdgeInsets.symmetric(
                          vertical: (kToolbarHeight -
                                      Get.textTheme.subtitle2!.fontSize!) /
                                  2 -
                              4),
                      indicatorColor: Get.theme.primaryColorDark,
                      labelColor: Get.theme.primaryColorDark,
                      labelStyle: Get.textTheme.subtitle2!
                          .copyWith(fontWeight: FontWeight.w700),
                      tabs: const [Text('Chung'), Text('Của tôi')],
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Get.theme.backgroundColor,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Get.theme.hintColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: const Color(0xFFF5F8FD),
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.getNotifications();
                },
                child: Obx(() => CustomList(
                      scrollDirection: Axis.vertical,
                      mainAxisCount: 1,
                      borderRadius: 0,
                      shrinkWrap: false,
                      scrollPhysics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      scrollController: controller.scrollController,
                      widthItem: Get.size.width,
                      backgroundColor: const Color(0xFFE1E9EC),
                      mainSpace: 1,
                      onClickItem: (index) {
                        controller.seen(controller.notifications[index]);
                      },
                      itemCount: controller.notifications.length,
                      customWidget: (index) =>
                          _buildChild(controller.notifications[index], index),
                    )),
              ))),
    );
  }

  Widget _buildChild(NotificationData notification, int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notification.payload?.notification?.title ?? '',
                  style: Get.textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  notification.payload?.notification?.body ?? '',
                  style: Get.textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Convert.stringToDateAnotherPattern(
                        notification.sentAt ?? '',
                        isAtc: true,
                        patternIn: 'yyyy-MM-ddTHH:mm:ss',
                        patternOut: 'dd/MM/yyyy - hh:mm a'),
                    textAlign: TextAlign.end,
                    style: Get.textTheme.headline5!
                        .copyWith(color: const Color(0xFFAAB1C5)),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ]),
        ),
        Positioned.fill(
            child: GetBuilder<NotificationController>(
          tag: 'notificationController',
          id: 'seen',
          initState: (_) {},
          builder: (_) {
            return Container(
              color: controller.isSeen(notification.id)
                  ? const Color(0xFFF5F8FD).withOpacity(0.6)
                  : Colors.transparent,
            );
          },
        ))
      ],
    );
  }
}
