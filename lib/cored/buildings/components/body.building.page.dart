// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:base/widgets/button.widget.dart';


// import '../building.controller.dart';

// class BodyBuildingPage extends StatelessWidget {
//   final controller = Get.find<BuildingController>();
//   BodyBuildingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(5),
//       shadowColor: Colors.grey.withOpacity(0.3),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.backgroundWhite),
//         child: Column(
//           children: <Widget>[
//             SearchBranch(),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TableHeader(),
//                     TableContent(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Obx(() => controller.currentPage.value == 1
//                             ? GestureDetector(
//                                 behavior: HitTestBehavior.translucent,
//                                 onTap: () {},
//                                 child: Icon(Icons.chevron_left_rounded,
//                                     color: Colors.grey))
//                             : GestureDetector(
//                                 behavior: HitTestBehavior.translucent,
//                                 onTap: () {
//                                   controller.backPage();
//                                 },
//                                 child: Icon(Icons.chevron_left_rounded))),
//                         Obx(() => Text((controller.minItem).toString())),
//                         Text('-'),
//                         Obx(() => Text(controller.maxItem.toString())),
//                         Text('/'),
//                         Obx(() => Text(controller.total.value.toString())),
//                         Obx(() =>
//                             controller.maxItem.value >= controller.total.value
//                                 ? GestureDetector(
//                                     behavior: HitTestBehavior.translucent,
//                                     onTap: () {},
//                                     child: Icon(MyFlutterApp.right_open,
//                                         color: Colors.grey))
//                                 : GestureDetector(
//                                     behavior: HitTestBehavior.translucent,
//                                     onTap: () {
//                                       controller.nextPage();
//                                     },
//                                     child: Icon(MyFlutterApp.right_open))),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchBranch extends StatelessWidget {
//   final controller = Get.find<BuildingController>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       margin: EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
          
//         ],
//       ),
//     );
//   }
// }
