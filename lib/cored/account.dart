import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'account.controller.dart';
import 'auth/auth.controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  final AccountController controller = Get.put(AccountController());

  AccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F8FD),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            AccountHeader(),
            const SizedBox(
              height: 16,
            ),
            AccountMenu(),
            CompanyInfo(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 70),
              child: BigButton(
                  color: Colors.white,
                  border: const BorderSide(color: Colors.red),
                  textColor: Colors.red,
                  evelation: 0,
                  function: () {
                    controller.logOut();
                  },
                  text: 'Đăng xuất'),
            )
          ],
        )));
  }
}

class CompanyInfo extends StatelessWidget {
  final sampleTitle = 'CÔNG TY CỔ PHẦN TẬP ĐOÀN TINGTONG';
  final sampleDescription =
      'TingTong.vn là công ty có nhiều năm kinh nghiệm trong lĩnh vực thuê và cho thuê nhà giá tốt nhất thị trường.';
  final sampleMail = 'Cityland@gmail.com';
  final samplePhone = '09 68 68 2135';
  final sampleAddress = 'Cau Giay, Ha Noi';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE1E9EC),
              blurRadius: 20,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE1E9EC))),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .doc('settingResident/companyInfo')
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          var title = sampleTitle;
          var description = sampleDescription;
          var mail = sampleMail;
          var phone = samplePhone;
          var address = sampleAddress;
          var linkAddress = sampleAddress;
          if (snapshot.data != null) {
            title = snapshot.data?['title'] ?? title;
            description = snapshot.data?['description'] ?? description;
            mail = snapshot.data?['mail'] ?? mail;
            phone = snapshot.data?['phone'] ?? phone;
            address = snapshot.data?['address'] ?? address;
            linkAddress = snapshot.data?['linkAddress'] ?? address;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.toString().toUpperCase(),
                  style: const TextStyle(
                      color: Color(0xFF16154E),
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              const SizedBox(height: 10),
              Text(description,
                  style:
                      const TextStyle(color: Color(0xFF16154E), fontSize: 14)),
              const SizedBox(height: 20),
              BoxContact(mail, Icons.mail, onClick: () {
                launch('mailTo:$mail');
              }),
              const SizedBox(height: 20),
              BoxContact(phone, MyFlutterApp.ic_mobile_phone, onClick: () {
                launch('tel:${phone.replaceAll(' ', '')}');
              }),
              const SizedBox(height: 20),
              BoxContact(address, MyFlutterApp.ic_address, onClick: () {
                launch(linkAddress);
              }),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

class BoxContact extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onClick;
  const BoxContact(this.text, this.icon, {Key? key, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onClick();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFDB913),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14)))
        ],
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  final AccountController controller = Get.find();

  AccountMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shadowColor: const Color(0xFF66677A).withOpacity(0.1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: ListView.separated(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return controller.getListMenu(index);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 2,
              );
            },
            itemCount: controller.listMenu.length));
  }
}

class AccountHeader extends StatelessWidget {
  final AuthController authController = Get.find(tag: 'authController');
  final controller = Get.find<AccountController>();

  AccountHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.size.height / 3 - 20,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(color: Get.theme.accentColor)),
              const SizedBox(
                height: 40,
              )
            ],
          ),
          Obx(() => Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: SizedBox(
                  height: 100,
                  width: Get.size.width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: Get.size.width,
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                color: Colors.white,
                                shadowColor:
                                    const Color(0xFF66677A).withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 110,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    authController.user.name ??
                                                        '',
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    authController
                                                            .user.phoneNumber ??
                                                        '',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30.0),
                                              child: Icon(
                                                  MyFlutterApp.right_open,
                                                  size: 20,
                                                  color:
                                                      Get.theme.primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 32,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.white, width: 5)),
                          child: Obx(() => ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Utilities.getImageNetwork(
                                      authController.avatar.value),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )))
        ],
      ),
    );
  }
}
