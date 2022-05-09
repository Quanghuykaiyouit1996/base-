import 'package:get/get.dart';
import 'package:base/cored/appointment/appointment.dart';
import 'package:base/cored/auth/blog/blog.dart';
import 'package:base/cored/auth/blog/blog.detail.dart';
import 'package:base/cored/auth/login/login.page.dart';
import 'package:base/cored/auth/otp/confirmOTP.page.dart';
import 'package:base/cored/bill/bill.contract.dart';
import 'package:base/cored/bill/contract/contract.invoice.dart';
import 'package:base/cored/bill/invoicedetail/invoice.detail.dart';
import 'package:base/cored/buildings/building.page.dart';
import 'package:base/cored/buildings/create_or_add/building.edit.page.dart';
import 'package:base/cored/buildings/info/building.info.page.dart';
import 'package:base/cored/checkout/checkout.dart';
import 'package:base/cored/contract/contract.dart';
import 'package:base/cored/contract/contractdetail/contract.detail.dart';
import 'package:base/cored/contract/contractrenewal/contract.renewal.dart';
import 'package:base/cored/notification/notification.page.dart';
import 'package:base/cored/profile/profile.dart';
import 'package:base/cored/review/review.dart';
import 'package:base/cored/review/reviewdetail/review.detail.page.dart';
import 'package:base/cored/review/reviewedit/review.edit.page.dart';
import 'package:base/cored/rooms/room.dart';
import 'package:base/cored/rooms/roomdetail/room.detail.page.dart';
import 'package:base/cored/webview/webview.page.dart';

import '../../app.dart';

part '../routes/app.routes.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.INITIAL,
      page: () => AppPage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => ConfirmOTPPage(),
    ),
    GetPage(
      name: Routes.BLOGDETAIL,
      page: () => BlogDetailPage(),
    ),
    GetPage(
      name: Routes.INVOICEDETAIL,
      page: () => InvoiceDetailPage(),
    ),
    GetPage(
      name: Routes.CONTRACTINVOICE,
      page: () => ContractInvoicePage(),
    ),
    GetPage(
      name: Routes.CONTRACTRENEWAL,
      page: () => ContractRenewalPage(),
    ),
    GetPage(
      name: Routes.ROOMDETAIL,
      page: () => RoomDetailPage(),
    ),
    GetPage(
      name: Routes.REVIEWEDIT,
      page: () => ReviewEditPage(),
    ),
    GetPage(
      name: Routes.REVIEWDETAIL,
      page: () => ReviewDetailPage(),
    ),
    GetPage(
      name: Routes.MY_REVIEW_ACCOUNT,
      page: () => ReviewPage(),
    ),
    GetPage(
      name: Routes.CONTRACTDETAIL,
      page: () => ContractDetailPage(),
    ),
    GetPage(
      name: Routes.CONTRACTMANAGER,
      page: () => ContractPage(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: Routes.BILL,
      page: () => BillPage(),
    ),
    GetPage(
      name: Routes.BLOG,
      page: () => BlogPage(),
    ),
    GetPage(
      name: Routes.ROOM,
      page: () => RoomPage(),
    ),
    GetPage(
      name: Routes.WEBVIEWPAGE,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: Routes.APPOITMENT,
      page: () => AppointmentPage(),
    ),
    GetPage(
      name: Routes.BUILDING,
      page: () => const BuildingPage(),
    ),
    GetPage(
      name: Routes.BUILDING_INFO,
      page: () => BuildingsInfoPage(),
    ),
    GetPage(
      name: Routes.EDITANDADDBUILDING,
      page: () => BuildingsAddAndEditPage(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
    ),
  ];
}
