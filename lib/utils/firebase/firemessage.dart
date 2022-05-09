import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import 'package:mobile_admin/cored/notification/notification.controller.dart';
import 'package:mobile_admin/cored/notification/notification.provider.dart';
import 'package:mobile_admin/models/auth.model.dart';
import 'package:mobile_admin/models/notification.model.dart';
import 'package:mobile_admin/utils/helpes/constant.dart';
import 'package:mobile_admin/utils/helpes/utilities.dart';
import 'package:mobile_admin/utils/service/my.connect.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

Future onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: Text('Ok'),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SecondScreen(payload),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   ),
  // );
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FireMessage {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    var provider = NotificationBackgroundProvider();
    print(jsonEncode(message.data));
    print('BackgroundHandler ${jsonEncode(message.data)}');
    // updateSeen(message.data['message_ids']);
    // Utilities.goToPage(message.data['screen'],
    //     id: message.data['redirect_id'] is int
    //         ? message.data['redirect_id']
    //         : int.tryParse(message.data['redirect_id']));
    // updateSeen(message.data['message_ids']);
    var response = await provider.getCountUnSeen(token: getToken());
    int count;
    if (response.isOk && response.body != null) {
      if (response.body['result'] is int) {
        count = response.body['result'] ?? 0;
      } else {
        count = int.tryParse(response.body['result']) ?? 0;
      }
      FlutterAppBadger.updateBadgeCount(count);
    }
  }

  static String getToken() {
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

  static void registerFirebase() async {
    var messaging = FirebaseMessaging.instance;
    var settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(
        FireMessage.firebaseMessagingBackgroundHandler);
    checkOpenAppFromTerminate();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      var notification = message.notification;
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channel.id, channel.name, channel.description,
          icon: 'app_icon',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);
      var notificationController =
          Get.find<NotificationController>(tag: 'notificationController');
      notificationController.getCountUnseenNotification();
      var platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(notification.hashCode ~/ 10000,
          notification?.title, notification?.body, platformChannelSpecifics,
          payload: json.encode(message.data));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      updateSeen(event.data);
      Utilities.goToPage(NotificationData(
          payload: Payload(data: DataPayload.fromJson(event.data))));
    });
  }

  static Future selectNotification(String? payload) async {
    if (payload != null) {
      updateSeen(json.decode(payload));
      Utilities.goToPage(NotificationData(
          payload: Payload(data: DataPayload.fromJson(json.decode(payload)))));
    }
  }

  static void registerToken(String token) async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      print('firebase: $value');
      try {
        var response =
            await TokenProvider().postToken(token: token, value: value);

        if (response.isOk) {}
      } catch (e) {
        e.printError();
      }
    });
  }

  static void removeToken(String token) async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      var httpClient = HttpClient();
      var request = await httpClient
          .deleteUrl(Uri.parse('${Constant.baseUrl}/registration_token'));
      request.headers.set('content-type', 'text/html');
      request.headers.set('Access-Token', token);
      request.add(utf8.encode(json.encode({'registration_token': value})));
      try {
        var response = await request.close();
        if (response.statusCode - 100 < 200) {}
      } catch (e) {
        e.printError();
      }
    });
  }

  static void checkOpenAppFromTerminate() async {
    var initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    //Check initialMessage
    if (initialMessage != null) {
      Future.delayed(const Duration(seconds: 2), () {
        updateSeen(initialMessage.data);
        Utilities.goToPage(NotificationData(
            payload: Payload(data: DataPayload.fromJson(initialMessage.data))));
      });
      return;
    }

    //Check is open from FlutterLocalNotificationsPlugin
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp &&
        notificationAppLaunchDetails?.payload != null) {
      var data = json.decode(notificationAppLaunchDetails?.payload ?? '{}');
      Future.delayed(const Duration(seconds: 2), () {
        updateSeen(data);
        Utilities.goToPage(NotificationData(
            payload: Payload(data: DataPayload.fromJson(json.decode(data)))));
      });
      return;
    }
  }

  static void updateSeen(Map<String, dynamic> message) {}
}

class TokenProvider extends MyConnect {
  TokenProvider();

  Future<Response> postToken({String? token, String? value}) =>
      request('${Constant.baseUrl}/customers/self/notifications/token', 'POST',
          contentType: 'application/json',
          body: {
            'token': value,
            'platform': Platform.operatingSystem
          },
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token ?? ''
          });
}

class NotificationBackgroundProvider extends MyConnect {
  NotificationBackgroundProvider();

  Future<Response> getCountUnSeen({String? token}) =>
      request('${Constant.baseUrl}/partner.message/count?is_seen=false', 'GET',
          contentType: 'text/html',
          headers: {'Content-Type': 'text/html', 'Authorization': token ?? ''});
}
