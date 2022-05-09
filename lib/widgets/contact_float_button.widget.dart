import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:tdic_mobile_app/constants/Image.asset.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ContactButtons extends StatefulWidget {
  final bool hasBottomBar;
  const ContactButtons({this.hasBottomBar = true});

  @override
  _ContactButtonsState createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  // // late AnimationController _controllerBackground;
  // ContactModel _contactModel = ContactModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _controllerBackground.dispose();
  }

  // Widget _buildFloatButton() {
  //   return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  //       stream: FirebaseFirestore.instance
  //           .collection('setting')
  //           .doc('contact')
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData &&
  //             snapshot.data != null &&
  //             snapshot.data?.data() != null) {
  //           _contactModel = ContactModel.fromJson(snapshot.data?.data() ?? {});
  //         }
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             (_contactModel.zalo != null &&
  //                     _contactModel.zalo?.value != null &&
  //                     _contactModel.zalo?.value != '' &&
  //                     _contactModel.zalo?.enabled == true)
  //                 ? Padding(
  //                     padding: const EdgeInsets.only(
  //                       right: 20,
  //                     ),
  //                     child: GestureDetector(
  //                         onTap: () {
  //                           try {
  //                             launch(_contactModel.zalo?.value ?? '',
  //                                 forceSafariVC: false, forceWebView: false);
  //                           } catch (e) {
  //                             print(e);
  //                           }
  //                         },
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   color: Colors.white),
  //                               width: 55,
  //                               height: 55,
  //                             ),
  //                             Icon(
  //                               ZaloIcon.iconZalo,
  //                               color: Colors.blue[600],
  //                               size: 55,
  //                             ),
  //                           ],
  //                         )),
  //                   )
  //                 : Container(),
  //             // (_contactModel.hotline != null &&
  //             //         _contactModel?.hotline?.value != null &&
  //             //         _contactModel?.hotline?.value != "" &&
  //             //         _contactModel?.hotline?.enabled == true)
  //             //     ? Container(
  //             //         child: Stack(
  //             //           alignment: Alignment.center,
  //             //           children: <Widget>[
  //             //             Container(
  //             //               width: 50,
  //             //               child: FloatingActionButton(
  //             //                 elevation: 1,
  //             //                 backgroundColor: AppColors().backgroundHotlineColor,
  //             //                 heroTag: 'hotline',
  //             //                 onPressed: () {
  //             //                   try {
  //             //                     launch(
  //             //                       "tel:${_contactModel?.hotline?.value}",
  //             //                     );
  //             //                   } catch (e) {
  //             //                     print(e);
  //             //                   }
  //             //                 },
  //             //                 tooltip: 'Hotline',
  //             //                 child: ShakeAnimatedWidget(
  //             //                   enabled: _enabledShake,
  //             //                   duration: Duration(milliseconds: 500),
  //             //                   shakeAngle: Rotation.deg(z: 20),
  //             //                   curve: Curves.linear,
  //             //                   child: Icon(
  //             //                     CustomIcons.icon_phone,
  //             //                     color: Colors.white,
  //             //                     size: 23.0,
  //             //                   ),
  //             //                 ),
  //             //               ),
  //             //             )
  //             //           ],
  //             //         ),
  //             //       )
  //             //     : Container(),
  //             (_contactModel.messenger != null &&
  //                     _contactModel.messenger?.value != null &&
  //                     _contactModel.messenger?.enabled == true)
  //                 ? Container(
  //                     padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
  //                     // margin: EdgeInsets.only(
  //                     //     bottom: widget.hasBottomBar == true ? 67 : 45),

  //                     child: FloatingActionButton(
  //                         elevation: 0,
  //                         backgroundColor: Colors.transparent,
  //                         heroTag: 'messenger',
  //                         onPressed: () {
  //                           try {
  //                             launch(_contactModel.messenger?.value ?? '',
  //                                 forceSafariVC: false, forceWebView: false);
  //                           } catch (e) {
  //                             print(e);
  //                           }
  //                         },
  //                         tooltip: 'Nhắn tin',
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               margin: EdgeInsets.only(top: 2, left: 3),
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   color: Colors.white),
  //                               width: 50,
  //                               height: 50,
  //                             ),
  //                             GradientIcon(
  //                                 BaoNgocIcon.facebook_messenger_logo_2020,
  //                                 53,
  //                                 RadialGradient(
  //                                   colors: <Color>[
  //                                     Color(0xFF0099FF),
  //                                     Color(0xFFA033FF),
  //                                     Color(0xFFFF5280),
  //                                     Color(0xFFFF7061),
  //                                   ],
  //                                   stops: [0, 0.6098, 0.934, 1],
  //                                   center: Alignment.bottomRight,
  //                                   radius: 1.0896,
  //                                   transform:
  //                                       GradientRotation(math.pi * 1 / 2),
  //                                 )),
  //                           ],
  //                         )),
  //                   )
  //                 : Container(),
  //             AnimatedContainer(
  //               duration: Duration(milliseconds: 500),
  //               height: widget.hasBottomBar ? 0 : 0,
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(),
    );
    // return Container();
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        final rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
