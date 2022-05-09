import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/custom.list.dart';

import 'contract.invoice.controller.dart';

class ContractInvoicePage extends StatelessWidget {
  final controller = Get.put(ContractInvoiceController());

  ContractInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý hóa đơn'),
        titleSpacing: 0,
      ),
      backgroundColor: Color(0xFFF5F8FD),
      body: Obx(() => CustomList(
            scrollDirection: Axis.vertical,
            mainAxisCount: 1,
            borderRadius: 6,
            widthItem: Get.size.width - 32,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            mainSpace: 10,
            crossSpace: 10,
            scrollController: controller.scrollController,
            itemCount: controller.contracts.length,
            customWidget: (index) => InfoContract(
              listInvoices:
                  controller.invoices[controller.contracts[index].id] ?? [],
              contract: controller.contracts[index],
            ),
          )),
    );
  }
}

class InfoContract extends StatelessWidget {
  final List<Invoice> listInvoices;
  final Contracts contract;

  const InfoContract({
    Key? key,
    required this.listInvoices,
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
            color: const Color(0xFFE5EDFA),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(contract.code ?? ''),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(contract.customer?.name ?? ''),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 4),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8))),
                          child: const Text('Chưa thanh toán',
                              style: TextStyle(
                                  color: Color(0xFFF39628),
                                  fontWeight: FontWeight.w600))),
                    ),
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.toNamed(Routes.BILL, arguments: contract);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Lịch sử hóa dơn',
                              style: TextStyle(
                                  color: Color(0xFF00A79E),
                                  fontWeight: FontWeight.w600)),
                          Icon(MyFlutterApp.right_open,
                              color: Color(0xFF00A79E))
                        ],
                      ),
                    )),
                  ],
                ),
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
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.INVOICEDETAIL, arguments: invoice.id);
      },
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
                        style: const TextStyle(fontSize: 14, height: 20 / 14)),
                    Text(
                        Convert.stringToDateAnotherPattern(
                            invoice.createdAt ?? '',
                            patternOut: 'dd/MM/yyyy'),
                        style: const TextStyle(fontSize: 12, height: 16 / 12))
                  ],
                ),
                const Icon(MyFlutterApp.right_open)
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(Convert.convertMoney(invoice.totalAmount),
                  style: const TextStyle(
                      color: Color(0xFF00A79E),
                      fontSize: 14,
                      height: 20 / 14,
                      fontWeight: FontWeight.w600)),
              SmallButton(
                function: () {
                  Get.toNamed(Routes.CHECKOUT, arguments: invoice);
                },
                text: 'Thanh toán',
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                iconSize: const Size(100, 30),
                color: const Color(0xFF454388),
              )
            ])
          ],
        ),
      ),
    );
  }
}
