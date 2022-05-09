import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/icon/custom.icon.dart';

import 'bill.controller.dart';

class BillPage extends StatelessWidget {
  final controller = Get.put(BillController());

  BillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử hóa đơn'),
        titleSpacing: 0,
      ),
      backgroundColor: const Color(0xFFF5F8FD),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Row(
                  children: [
                    Text(controller.contract.value.code ?? '',
                        style: const TextStyle(
                            color: Color(0xFF16154E),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            height: 20 / 14)),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(controller.contract.value.customer?.name ?? '',
                        style: const TextStyle(
                            color: Color(0xFF454388),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            height: 20 / 14)),
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.INVOICEDETAIL,
                              arguments: controller.invoices[index].id);
                        },
                        behavior: HitTestBehavior.translucent,
                        child:
                            InfoInvoice(invoice: controller.invoices[index]));
                  },
                  itemCount: controller.invoices.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                )),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
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
                      style: const TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: Color(0xFF454388)))
                ],
              ),
              const Icon(MyFlutterApp.right_open)
            ],
          ),
          const SizedBox(height: 8),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(Convert.convertMoney(invoice.totalAmount),
                    style: const TextStyle(
                        color: Color(0xFF00A79E),
                        fontWeight: FontWeight.w600,
                        height: 20 / 14,
                        fontSize: 14)),
                Text(invoice.status.toShortString(),
                    style: TextStyle(
                        color: invoice.status.getColorString(),
                        fontWeight: FontWeight.w600,
                        height: 16 / 12))
              ])
        ],
      ),
    );
  }
}
