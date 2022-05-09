import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/decorate.bottom.appbar.dart';

import 'contract.controller.dart';

class ContractPage extends StatelessWidget {
  final controller = Get.put(ContractController());

  ContractPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Quản lý hợp đồng'),
          titleSpacing: 0,
          bottom: DecoratedTabBar(
            tabBar: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: TabBar(
                onTap: (index) {
                  controller.changeTab(index);
                },
                unselectedLabelColor: const Color(0xFF9D9BC9).withOpacity(0.5),
                indicatorWeight: 2.0,
                labelPadding: EdgeInsets.symmetric(
                    vertical:
                        (kToolbarHeight - Get.textTheme.subtitle2!.fontSize!) /
                                2 -
                            4),
                indicatorColor: Get.theme.primaryColorDark,
                labelColor: Get.theme.primaryColorDark,
                labelStyle: Get.textTheme.subtitle2!
                    .copyWith(fontWeight: FontWeight.w700),
                tabs: const [Text('Còn hiệu lực'), Text('Hết hiệu lực')],
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Get.theme.backgroundColor,
                  width: 2.0,
                ),
                bottom: BorderSide(
                  color: Get.theme.hintColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF5F8FD),
        body: Obx(() => CustomList(
              scrollDirection: Axis.vertical,
              mainAxisCount: 1,
              borderRadius: 6,
              widthItem: Get.size.width - 32,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              mainSpace: 10,
              crossSpace: 10,
              onClickItem: (index) {
                Get.toNamed(Routes.CONTRACTDETAIL,
                    arguments: controller.contracts[index]);
              },
              itemCount: controller.contracts.length,
              customWidget: (index) =>
                  InfoContract(contract: controller.contracts[index]),
            )));
  }
}

class InfoContract extends StatelessWidget {
  final Contracts contract;

  const InfoContract({
    Key? key,
    required this.contract,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            color: const Color(0xFFF5F5F5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(contract.code ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, height: 1.5)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: contract
                                    .getStatus()
                                    .getColorString()
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(contract.getStatus().toShortString(),
                                style: TextStyle(
                                    color:
                                        contract.getStatus().getColorString())),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: const [
                        Text('Chi tiết',
                            style: TextStyle(color: Color(0xFF9D9BC9))),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(MyFlutterApp.right_open, color: Color(0xFF9D9BC9))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(MyFlutterApp.ic_profile,
                        color: Color(0xFF00A79E)),
                    const SizedBox(width: 4),
                    Text(contract.customer?.name ?? '')
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(MyFlutterApp.ic_home, color: Color(0xFF00A79E)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                          '${contract.buildingName ?? ''} | ${contract.roomName ?? ''}'),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
