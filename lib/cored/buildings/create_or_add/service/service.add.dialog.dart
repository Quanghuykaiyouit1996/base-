// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/components/image.list.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/components/required.text.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/service/service.add.controller.dart';
// import 'package:smb_builder_web_client/pages/shared/widget_custom/button.dropdown.dart';
// import 'package:smb_builder_web_client/pages/shared/widget_custom/button.widget.dart';
// import 'package:smb_builder_web_client/pages/shared/widget_custom/text.form.widget.dart';

// class AddServiceInBuildingDialog extends StatelessWidget {
//   final AddServiceInBuildingController controller;
//   AddServiceInBuildingDialog(this.controller);
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 600,
//         color: Colors.white,
//         child: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: formKey,
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Obx(() => Text(
//                         controller.service.value.id != null
//                             ? 'SỬA SẢN PHẨM'
//                             : 'THÊM SẢN PHẨM',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )),
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       behavior: HitTestBehavior.translucent,
//                       child: Icon(MyFlutterApp.exit))
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Divider(),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(flex: 1, child: ServiceTypeWidget()),
//                   SizedBox(width: 16),
//                   Expanded(flex: 2, child: ServiceNameWidget())
//                 ],
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(flex: 1, child: ServiceUnitWidget()),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   Expanded(flex: 2, child: ServicePriceWidget())
//                 ],
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 'Hình ảnh',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               ImageList(controller: controller.imageListController),
//               SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 'Mô tả',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Container(
//                 color: Color(0xFFF7F9FC),
//                 padding: EdgeInsets.all(2),
//                 child: Column(
//                   children: [
//                     quill.QuillToolbar.basic(
//                       controller: controller.quillController,
//                     ),
//                     Divider(),
//                     Container(
//                       height: 100,
//                       width: double.infinity,
//                       child: quill.QuillEditor.basic(
//                         controller: controller.quillController,
//                         readOnly: false, // true for view only mode
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 'Tag',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               ListTag(),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   SmallButton(
//                     iconSize: Size(120, 40),
//                     function: () {
//                       controller.cancelFix(context);
//                     },
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey),
//                     textColor: Colors.grey,
//                     text: 'Hủy bỏ',
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Obx(() => SmallButton(
//                       iconSize: Size(120, 40),
//                       function: () {
//                         if (formKey.currentState?.validate() ?? false) {
//                           controller.addNew(context);
//                         }
//                       },
//                       color: Color(0xFF19CBA0),
//                       textColor: Colors.white,
//                       text: controller.service.value.id == null
//                           ? 'Thêm mới'
//                           : 'Chỉnh sửa'))
//                 ],
//               ),
//             ]),
//           ),
//         )));
//   }
// }

// class ListTag extends StatelessWidget {
//   final controller = Get.find<AddServiceInBuildingController>();

//   @override
//   Widget build(BuildContext context) {
//     var focusNode = FocusNode();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           cursorHeight: 20,
//           enableInteractiveSelection: true,
//           autofocus: true,
//           focusNode: focusNode,
//           readOnly: false,
//           toolbarOptions: ToolbarOptions(
//               paste: true, cut: true, selectAll: true, copy: true),
//           decoration: InputDecoration(
//               hintText: 'Nhập nhãn (tag)',
//               fillColor: Color(0xFFF2F4FB),
//               filled: true,
//               border: InputBorder.none),
//           onFieldSubmitted: (value) {
//             controller.listTag.add(value);
//             controller.tagEditorController.text = '';
//             focusNode.requestFocus();
//           },
//           controller: controller.tagEditorController,
//         ),
//         Obx(() => Wrap(
//             spacing: 4,
//             runSpacing: 4,
//             children: controller.listTag
//                 .map((element) => Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         color: Color(0xFF277FF5)),
//                     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           element,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         GestureDetector(
//                           behavior: HitTestBehavior.translucent,
//                           onTap: () {
//                             controller.listTag.remove(element);
//                           },
//                           child: Icon(
//                             MyFlutterApp.exit,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         )
//                       ],
//                     )))
//                 .toList()))
//       ],
//     );
//   }
// }

// class ServiceUnitWidget extends StatelessWidget {
//   final controller = Get.find<AddServiceInBuildingController>();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Đơn vị', style: TextStyle(fontWeight: FontWeight.w600)),
//         SizedBox(
//           height: 4,
//         ),
//         TextFormFieldLogin(
//           isCollapsed: true,
//           borderColor: Color(0xFFEDF1F5),
//           controller: controller.unitNameController,
//         )
//       ],
//     );
//   }
// }

// class ServicePriceWidget extends StatelessWidget {
//   final controller = Get.find<AddServiceInBuildingController>();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RequiredText(isBold: true, text: 'Đơn giá'),
//         SizedBox(
//           height: 4,
//         ),
//         TextFormFieldUnit(
//             isCollapsed: true,
//             unit: 'đ',
//             borderColor: Color(0xFFEDF1F5),
//             controller: controller.priceController,
//             validator: controller.priceValidator)
//       ],
//     );
//   }
// }

// class ServiceNameWidget extends StatelessWidget {
//   final controller = Get.find<AddServiceInBuildingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RequiredText(isBold: true, text: 'Tên dịch vụ'),
//         SizedBox(
//           height: 4,
//         ),
//         TextFormFieldLogin(
//             isCollapsed: true,
//             borderColor: Color(0xFFEDF1F5),
//             controller: controller.serviceNameController,
//             validator: controller.serviceNameValidator)
//       ],
//     );
//   }
// }

// class ServiceTypeWidget extends StatelessWidget {
//   final controller = Get.find<AddServiceInBuildingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RequiredText(isBold: true, text: 'Loại sản phẩm'),
//         SizedBox(
//           height: 4,
//         ),
//         Obx(() => controller.listType.isEmpty
//             ? Container()
//             : Stack(
//                 children: [
//                   TextFormFieldLogin(
//                       isCollapsed: true,
//                       borderColor: Color(0xFFEDF1F5),
//                       controller: controller.serviceTypeController,
//                       validator: controller.serviceTypeValidator),
//                   ButtonDropdown<String>(
//                     items: controller.listType,
//                     callback: (value) {
//                       controller.serviceTypeController.text = value;
//                     },
//                     hintText: 'Loại nhà',
//                     selectedItem: controller.type,
//                     childs: controller.listType.map((item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               )),
//       ],
//     );
//   }
// }
