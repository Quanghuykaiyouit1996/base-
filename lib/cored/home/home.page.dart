import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/app.controller.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/icon.notification.dart';
import 'banner/banner.dart';
import 'bloghorizontal/blog.horizontal.controller.dart';
import 'bloghorizontal/blog.horizontal.dart';
import 'home.controller.dart';
import 'mainslider/main.slider.widget.dart';
import 'widgets/bill.need.pay.widget.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find(tag: 'authController');
  final AppController appController = Get.find<AppController>();

  final homeController = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shadowColor: Colors.transparent,
        toolbarHeight: 50,
        title: Obx(() => Text('Xin chào, ${authController.user.name}')),
        titleSpacing: 0,
        backgroundColor: const Color(0xFF16154E),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Center(
                child: IconNotification(
              iconColor: const Color(0xFF9D9BC9),
            )),
          )
        ],
        leadingWidth: 16,
        leading: const SizedBox.shrink(),
      ),
      backgroundColor: const Color(0xFFF5F8FD),
      body: SingleChildScrollView(
        controller: appController.controllerScroll,
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 80,
                child: Stack(
                  children: [
                    Container(
                      height: 30,
                      color: const Color(0xFF16154E),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed(Routes.CONTRACTINVOICE);
                            },
                            child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: const [
                                    Icon(MyFlutterApp.ic_invoice_management,
                                        size: 30, color: Color(0xFFFDB913)),
                                    SizedBox(width: 8),
                                    Expanded(
                                        child: Text(
                                      'Quản lý hóa đơn',
                                      style: TextStyle(
                                          fontSize: 12,
                                          height: 16 / 12,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    SizedBox(width: 8),
                                    Icon(
                                      MyFlutterApp.right_open,
                                      color: Color(0xFF454388),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed(Routes.CONTRACTMANAGER);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Icon(MyFlutterApp.ic_contract_management,
                                        size: 30,
                                        color: const Color(0xFF00A79E)
                                            .withOpacity(0.4)),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                        child: Text(
                                      'Quản lý hợp đồng',
                                      style: TextStyle(
                                          fontSize: 12,
                                          height: 16 / 12,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      MyFlutterApp.right_open,
                                      color: Color(0xFF454388),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              height: 16,
            ),
            BillNeedPay(),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => CustomList(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                backgroundColor: Colors.transparent,
                itemCount:
                    homeController.setting.value.screens?.mainScreen?.length ??
                        0,
                customWidget: (index) {
                  var mainScreen =
                      homeController.setting.value.screens?.mainScreen?[index];
                  if (mainScreen != null &&
                      mainScreen.type == 'section_blog' &&
                      mainScreen.items != null &&
                      mainScreen.items!.isNotEmpty &&
                      mainScreen.items!.first.type == 'blog') {
                    return BlogHorizotalPage(
                      title: 'Tin tức',
                      controller: Get.put(
                          BlogHorizontalController(mainScreen.items?.first),
                          tag: mainScreen.items?.first.value),
                    );
                  } else if (mainScreen != null &&
                      mainScreen.type == 'section_banner' &&
                      mainScreen.items != null &&
                      mainScreen.items!.isNotEmpty) {
                    return BannerHome(mainScreen.items!.first);
                  } else if (mainScreen != null &&
                      mainScreen.type == 'banner_slider' &&
                      mainScreen.items != null &&
                      mainScreen.items!.isNotEmpty) {
                    return BannerSlidderHome(item: mainScreen.items);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
