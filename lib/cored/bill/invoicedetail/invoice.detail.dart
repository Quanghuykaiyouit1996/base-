import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/button.widget.dart';

import 'invoice.detail.controller.dart';

class InvoiceDetailPage extends StatelessWidget {
  final controller = Get.put(InvoiceDetailController());

  InvoiceDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.invoice.value.name ?? '')),
        titleSpacing: 0,
      ),
      backgroundColor: const Color(0xFFF5F8FD),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BaseInfo(),
                const SizedBox(height: 16),
                ProductInfo(),
                const SizedBox(height: 16),
                ImageInvoiceInfo(),
                const SizedBox(height: 16),
                NoteInfo(),
                const SizedBox(height: 16),
                if (controller.invoice.value.status == BillStatus.unpayment)
                  BigButton(
                    function: () {
                      Get.toNamed(Routes.CHECKOUT,
                          arguments: controller.invoice.value);
                    },
                    color: const Color(0xFF454388),
                    text: 'Thanh toán',
                    borderRadius: BorderRadius.circular(8),
                  )
              ],
            ),
          )),
    );
  }
}

class NoteInfo extends StatelessWidget {
  final controller = Get.find<InvoiceDetailController>();

  NoteInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ghi chú', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(controller.invoice.value.note ?? '')
        ],
      ),
    );
  }
}

class ImageInvoiceInfo extends StatelessWidget {
  final controller = Get.find<InvoiceDetailController>();

  ImageInvoiceInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ảnh hóa đơn',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          LayoutBuilder(builder: (context, constrant) {
            var distanceItem = 6.0;
            var width = (constrant.constrainWidth() - 12) / 3;
            return Wrap(
              spacing: distanceItem,
              runSpacing: distanceItem,
              children: controller.invoice.value.images
                      ?.map((e) => SizedBox(
                          height: width,
                          width: width,
                          child: Utilities.getImageNetwork(e)))
                      .toList() ??
                  [],
            );
          }),
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final controller = Get.find<InvoiceDetailController>();

  ProductInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                flex: 5,
                child: Text('Tên sản phẩm',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                flex: 3,
                child: Text('Đơn giá',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Số lượng',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Thành tiền',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          ...controller.invoice.value.items
                  ?.map((e) => Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text('${e.name} - ${e.unit}'),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(Convert.convertMoney(e.price)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(e.quantity.toString()),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child:
                                    Text(Convert.convertMoney(e.totalAmount))),
                          ),
                        ],
                      ))
                  .toList() ??
              [],
          const Divider(height: 31),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tạm tính'),
              Text(Convert.convertMoney(controller.invoice.value.amount)),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Khuyến mãi'),
              Text(
                  '- ${Convert.convertMoney(controller.invoice.value.discountAmount)}'),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng cộng', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(Convert.convertMoney(controller.invoice.value.totalAmount),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFF00948C))),
            ],
          )
        ],
      ),
    );
  }
}

class BaseInfo extends StatelessWidget {
  final controller = Get.find<InvoiceDetailController>();

  BaseInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var invoice = controller.invoice.value;
    var contract = invoice.contract;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(invoice.code ?? '',
                  style: const TextStyle(
                    color: Color(0xFF16154E),
                    fontSize: 12,
                    height: 16 / 12,
                  )),
              invoice.status == BillStatus.unpayment
                  ? const SizedBox.shrink()
                  : Text(invoice.status.toShortString(),
                      style: TextStyle(color: invoice.status.getColorString()))
            ],
          ),
          Text.rich(TextSpan(
              text: '${contract?.code ?? ''}   ',
              style: const TextStyle(fontSize: 14, height: 20 / 14),
              children: [
                TextSpan(
                  text: contract?.customer?.name ?? '',
                  style: TextStyle(
                      color: Color(0xFF454388), fontSize: 14, height: 20 / 14),
                )
              ])),
          Text.rich(TextSpan(
              text: contract?.roomName ?? '',
              style: TextStyle(fontSize: 14, height: 20 / 14),
              children: [
                TextSpan(text: ' | '),
                TextSpan(text: contract?.buildingName ?? '')
              ])),
          Text.rich(TextSpan(
              text: 'Ngày tạo ',
              style: TextStyle(
                  fontSize: 10, height: 12 / 10, color: Color(0xFF9D9BC9)),
              children: [
                TextSpan(
                    text: Convert.stringToDateAnotherPattern(
                        invoice.createdAt ?? '',
                        patternOut: 'dd/MM/yyyy'))
              ])),
        ],
      ),
    );
  }
}
