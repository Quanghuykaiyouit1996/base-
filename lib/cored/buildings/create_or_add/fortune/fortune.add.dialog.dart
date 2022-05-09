// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smb_builder_web_client/config/app_colors.dart';
// import 'package:smb_builder_web_client/pages/shared/content_item_cell.dart';
// import 'package:smb_builder_web_client/pages/shared/model/room.model.dart';
// import 'package:smb_builder_web_client/pages/shared/widget_custom/button.widget.dart';
// import 'package:smb_builder_web_client/pages/shared/widget_custom/search.input.dart';
// import 'package:smb_builder_web_client/utility/Utilities.dart';

// import 'fortune.add.controller.dart';

// class AddFortuneInBuildingDialog extends StatelessWidget {
//   final AddFortuneInBuildingController controller;
//   AddFortuneInBuildingDialog(this.controller);
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 600,
//         color: Colors.white,
//         child: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'DANH SÁCH TÀI SẢN',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             behavior: HitTestBehavior.translucent,
//                             child: Icon(MyFlutterApp.exit))
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Divider(),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 43,
//                       child: SearchInput(
//                         controller: controller.searchController,
//                         focusNode: FocusNode(),
//                         onChanged: (text) {
//                           controller.searchText(text);
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           TableHeader(),
//                           TableContent(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         SmallButton(
//                           iconSize: Size(120, 40),
//                           function: () {
//                             controller.cancelFix(context);
//                           },
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey),
//                           textColor: Colors.grey,
//                           text: 'Hủy bỏ',
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         SmallButton(
//                             iconSize: Size(120, 40),
//                             function: () {
//                               controller.addNew(context);
//                             },
//                             color: Color(0xFF19CBA0),
//                             textColor: Colors.white,
//                             text: 'Thêm')
//                       ],
//                     ),
//                   ],
//                 ))));
//   }
// }

// class TableHeader extends StatelessWidget {
//   final controller = Get.find<AddFortuneInBuildingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       columnWidths: {
//         0: FlexColumnWidth(1),
//         1: FlexColumnWidth(8),
//         2: FlexColumnWidth(4),
//       },
//       border: TableBorder.all(
//         color: AppColors.borderGrey,
//       ),
//       children: [
//         TableRow(
//             decoration: BoxDecoration(
//               color: Color(0xFF678CFF).withOpacity(0.15),
//             ),
//             children: <Widget>[
//               TableCell(
//                 verticalAlignment: TableCellVerticalAlignment.middle,
//                 child: Obx(() => Checkbox(
//                     onChanged: (bool? value) {
//                       controller.checkAll.value = !controller.checkAll.value;
//                     },
//                     value: controller.checkAll.value)),
//               ),
//               TableCell(
//                 verticalAlignment: TableCellVerticalAlignment.middle,
//                 child: ContentItemCell('Đơn vị', 15, isHeader: true),
//               ),
//               TableCell(
//                 verticalAlignment: TableCellVerticalAlignment.middle,
//                 child: ContentItemCell('Giá sản phẩm', 15,
//                     isHeader: true, aligment: Alignment.centerRight),
//               ),
//             ]),
//       ],
//     );
//   }
// }

// class TableContent extends StatelessWidget {
//   final controller = Get.find<AddFortuneInBuildingController>();
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Table(
//             columnWidths: {
//               0: FlexColumnWidth(1),
//               1: FlexColumnWidth(8),
//               2: FlexColumnWidth(4),
//             },
//             border: TableBorder.all(
//               // bottom: BorderSide(color: AppColors.borderGrey, width: 1),
//               // left: BorderSide(color: AppColors.borderGrey, width: 1),
//               // right: BorderSide(color: AppColors.borderGrey, width: 1),
//               color: AppColors.borderGrey,
//               width: 0.5,

//               // verticalInside: BorderSide(color: AppColors.borderGrey, width: 1),
//               // horizontalInside: BorderSide(color: AppColors.borderGrey, width: 1),
//               // top: BorderSide.none
//             ),
//             children: controller.services
//                 .map((service) => getListBranchItem(
//                     controller.services.indexOf(service), service, context))
//                 .toList()));
//   }

//   TableRow getListBranchItem(int index, Services item, BuildContext context) {
//     return TableRow(
//         decoration: BoxDecoration(
//             color:
//                 index % 2 == 0 ? Color(0xFFF7F9FC) : AppColors.backgroundWhite),
//         children: <Widget>[
//           TableCell(
//             verticalAlignment: TableCellVerticalAlignment.middle,
//             child: (item.roomContant.isNotEmpty ||
//                         item.buildingContant.isNotEmpty) &&
//                     controller.buildingId.value != item.roomContant &&
//                     controller.buildingId.value != item.buildingContant
//                 ? Checkbox(
//                     onChanged: (bool? value) {},
//                     fillColor: fillColor,
//                     value: true)
//                 : ValueListenableBuilder<bool>(
//                     valueListenable: controller.listCheckBox[item.id]!,
//                     builder: (context, snapshot, child) {
//                       return Checkbox(
//                           onChanged: (bool? value) {
//                             if (value ?? false) {
//                               controller.chooseService.add(item);
//                             } else {
//                               controller.chooseService.remove(item);
//                             }
//                             controller.listCheckBox[item.id]!.value =
//                                 !controller.listCheckBox[item.id]!.value;
//                           },
//                           value: controller.listCheckBox[item.id]!.value);
//                     }),
//           ),
//           TableCell(
//             verticalAlignment: TableCellVerticalAlignment.middle,
//             child: ContentItemCell(
//               item.name ?? '—',
//               15,
//             ),
//           ),
//           TableCell(
//             verticalAlignment: TableCellVerticalAlignment.middle,
//             child: ContentItemCell(Utilities.convertMoney(item.maxPrice), 15,
//                 aligment: Alignment.centerRight),
//           ),
//         ]);
//   }

//   MaterialStateProperty<Color> get fillColor {
//     return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       return Color(0xFF9D9BC9).withOpacity(0.4);
//     });
//   }
// }
