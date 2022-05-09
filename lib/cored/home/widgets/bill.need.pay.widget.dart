import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/home/home.controller.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/custom.list.dart';

class BillNeedPay extends StatelessWidget {
  final controller = Get.find<HomeController>();

  BillNeedPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(
        () => controller.billsNeedPay.isEmpty
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFDB913),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          const Icon(
                            MyFlutterApp.ic_notification_2,
                            color: Color(0xFF454388),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                              child: Text(
                                  'Bạn có ${controller.billsNeedPay.length} hóa đơn chờ thanh toán',
                                  style: const TextStyle(
                                      color: Color(0xFF454388),
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => CustomList(
                          shrinkWrap: true,
                          mainSpace: 16,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.listContract.keys.length,
                          widthItem: Get.width - 32 - 2,
                          customWidget: (index) {
                            return InfoContract(
                                listInvoices: controller.listContract.values
                                    .elementAt(index));
                          },
                        ))
                  ],
                ),
              ),
      )
    ]);
  }
}

class InfoContract extends StatelessWidget {
  final List<Invoice> listInvoices;

  const InfoContract({
    Key? key,
    required this.listInvoices,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var contract = listInvoices
        .firstWhere((element) => element.contract?.id != null,
            orElse: () => Invoice())
        .contract;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE5EDFA),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            color: const Color(0xFFE5EDFA),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(contract?.code ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 4,
                ),
                Text(contract?.customer?.name ?? ''),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return InfoInvoice(invoice: listInvoices[index]);
            },
            itemCount: listInvoices.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            },
          ),
        ],
      ),
    );
  }
}

class InfoInvoice extends StatelessWidget {
  final Invoice invoice;

  const InfoInvoice({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.INVOICEDETAIL, arguments: invoice.id);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                        TextSpan(text: invoice.name, children: [
                          const TextSpan(text: ' - '),
                          TextSpan(text: invoice.type)
                        ]),
                        style: const TextStyle(fontSize: 14)),
                    Text(
                        Convert.stringToDateAnotherPattern(
                            invoice.createdAt ?? '',
                            patternOut: 'dd/MM/yyyy'),
                        style: const TextStyle(color: Color(0xFF454388)))
                  ],
                ),
                const Icon(MyFlutterApp.right_open)
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(Convert.convertMoney(invoice.totalAmount),
                  style: const TextStyle(
                      color: Color(0xFF00A79E), fontWeight: FontWeight.bold)),
              SmallButton(
                function: () {
                  Get.toNamed(Routes.CHECKOUT, arguments: invoice);
                },
                text: 'Thanh toán',
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                iconSize: const Size(100, 30),
              )
            ])
          ],
        ),
      ),
    );
  }
}
