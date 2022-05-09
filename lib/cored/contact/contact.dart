import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:base/constants/Image.asset.dart';
import 'package:base/utils/custom.icon.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact.controller.dart';

class ContactPage extends StatelessWidget {
  final controller = Get.put(ContactController());

  ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: SizedBox(
              height: 60, child: Image.asset(ImageAsset.pathLogoWhite)),
          titleSpacing: 0,
          toolbarHeight: 76,
        ),
        backgroundColor: const Color(0xFFF5F8FD),
        body: Column(
          children: [
            Container(
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
                    .doc('settingResident/contact')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data == null) return const SizedBox.shrink();
                  var title = snapshot.data!['title'];
                  var description = snapshot.data!['description'];
                  var linkFB = snapshot.data!['linkFB'];
                  var linkYT = snapshot.data!['linkYT'];
                  var linkTikTok = snapshot.data!['linkTikTok'];
                  var linkZalo = snapshot.data!['linkZalo'];
                  var linkMessage = snapshot.data!['linkMessage'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title.toString().toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xFF16154E),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      SizedBox(height: 10),
                      Text(description,
                          style: const TextStyle(
                              color: Color(0xFF16154E), fontSize: 14)),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: BoxSocial(linkFB, ImageAsset.pathFB),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BoxSocial(linkYT, ImageAsset.pathYT),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BoxSocial(linkTikTok, ImageAsset.pathTikTok),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BoxSocial(linkZalo, ImageAsset.pathZalo),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child:
                                BoxSocial(linkMessage, ImageAsset.pathMessage),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
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
                    .doc('settingResident/contact')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data == null) return const SizedBox.shrink();
                  var phone = snapshot.data!['phone'];

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      launch('tel:$phone');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyFlutterApp.ic_phone,
                            color: Color(0xFFFDB913)),
                        const SizedBox(width: 20),
                        Text.rich(TextSpan(
                            text: 'Tổng đài CSKH ',
                            style: const TextStyle(
                                color: Color(0xFF00A79E), fontSize: 15),
                            children: [
                              TextSpan(
                                  text: phone.toString().toUpperCase(),
                                  style: const TextStyle(
                                      color: Color(0xFFFDB913), fontSize: 15))
                            ])),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       canLaunch('tel:19002929').then((bool result) {
            //         if (result) {
            //           launch('tel:19002929');
            //         }
            //       });
            //     },
            //     behavior: HitTestBehavior.translucent,
            //     child: Row(
            //       children: const [
            //         Icon(MyFlutterApp.ic_phone, color: Color(0xFF00A79E)),
            //         SizedBox(
            //           width: 20,
            //         ),
            //         Text('Hotline 19002929',
            //             style: TextStyle(
            //                 color: Color(0xFF454388),
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 16))
            //       ],
            //     ),
            //   ),
            // ),
            // const Divider(
            //   height: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       launch('http://zalo.me/0707307125');
            //     },
            //     behavior: HitTestBehavior.translucent,
            //     child: Row(
            //       children: const [
            //         Icon(
            //           ZaloIcon.iconZalo,
            //           color: Colors.blueAccent,
            //         ),
            //         SizedBox(
            //           width: 20,
            //         ),
            //         Text('Zalo',
            //             style: TextStyle(
            //                 color: Color(0xFF454388),
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 16))
            //       ],
            //     ),
            //   ),
            // ),
            // const Divider(
            //   height: 1,
            // ),
          ],
        ));
  }
}

class BoxSocial extends StatelessWidget {
  final String logo;
  final String url;
  const BoxSocial(this.url, this.logo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        launch(url);
      },
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE1E9EC))),
          child: SizedBox(
              child: SizedBox(
                  child: Image.asset(
            logo,
            fit: BoxFit.fill,
          )))),
    );
  }
}
