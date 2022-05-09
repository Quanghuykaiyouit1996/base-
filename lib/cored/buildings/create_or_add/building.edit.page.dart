import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'building.edit.controller.dart';
import 'components/building.info.dart';
import 'components/component.dart';
import 'components/description.info.dart';
import 'components/investor.info.dart';

class BuildingsAddAndEditPage extends StatelessWidget {
  final controller = Get.put(BuildingsAddAndEditController());

  final _formKey = GlobalKey<FormState>();

  BuildingsAddAndEditPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F8FD),
        actions: [
          IconButton(
            icon: Text(controller.buildingId == null ? 'Thêm' : 'Sửa',
                style: const TextStyle(
                  color: Color(0xFF00A79E),
                )),
            onPressed: () {
              _formKey.currentState!.validate()
                  ? Get.snackbar("noti", 'success')
                  : Get.snackbar("Lỗi", 'Chưa nhập đủ thông tin');
            },
          )
        ],
        title: Text(
            controller.buildingId == null ? 'Tạo nhà' : 'Sửa thông tin nhà'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Component(
                index: 1,
                title: 'Thông tin chủ đầu tư',
                widgetChild: InvestorInfo(),
              ),
              Component(
                index: 2,
                title: 'Thông tin tòa nhà',
                widgetChild: BuildingInfo(),
              ),
              Component(
                index: 3,
                title: 'Mô tả chi tiết',
                widgetChild: DescriptionInfo(),
              )
              // HeaderBuildingEditPage(_formKey),
              // SizedBox(
              //   height: 32,
              // ),
              // BodyBuildingEditPage(_formKey),
            ],
          ),
        ),
      ),
    );
  }
}
