import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:base/models/bill.model.dart';
import 'package:base/models/payment.method.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/widgets/custom.list.dart';

import 'checkout.controller.dart';

class CheckoutPage extends StatelessWidget {
  final controller = Get.put(CheckoutController());

  CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phương thức thanh toán'),
        titleSpacing: 0,
      ),
      backgroundColor: Color(0xFFF5F8FD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFFF6E9)),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tổng tiền',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF39628))),
                      Text(
                          Convert.convertMoney(controller.invoice?.totalAmount))
                    ],
                  )),
              const SizedBox(
                height: 12,
              ),
              const Text('Chọn phương thức thanh toán',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black.withOpacity(0.6))),
                child: Obx(() => CustomList(
                      itemCount: controller.paymentMethods.length,
                      mainAxisCount: 1,
                      borderRadius: 6,
                      customWidget: (index) {
                        return Obx(() => Column(
                              children: [
                                if (index != 0)
                                  const Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ListTileTheme(
                                    contentPadding: EdgeInsets.all(0),
                                    child: RadioListTile<Methods>(
                                      activeColor: Get.theme.primaryColor,
                                      title: Text(controller
                                              .paymentMethods[index].name ??
                                          ''),
                                      value: controller.paymentMethods[index],
                                      groupValue:
                                          controller.paymentMenthod.value,
                                      onChanged: controller.changeDelivery,
                                    )),
                                Obx(() => controller.paymentMethods[index]
                                            .isBankTranfer &&
                                        (controller.paymentMenthod.value
                                                ?.isBankTranfer ??
                                            false)
                                    ? BankTranferItem(
                                        controller.paymentMenthod.value,
                                        controller.invoice)
                                    : const SizedBox.shrink())
                              ],
                            ));
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankTranferItem extends StatelessWidget {
  final Methods? value;
  final Invoice? invoice;
  const BankTranferItem(this.value, this.invoice);

  @override
  Widget build(BuildContext context) {
    var bankAccount = '';
    var bankName = '';
    var accountName = '';
    var list = value?.description?.split('-') ?? [];
    if (list.isNotEmpty && list.length > 3) {
      bankAccount = list[3].split('####')[0].split(' ')[2];
      bankName = list[0];
      accountName = list[2].split(":")[1];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F8FD),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                        text: 'Chủ tài khoản: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: accountName,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ]),
                  ),
                  ButtonCoppy(content: accountName)
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                        text: 'Số tài khoản: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: bankAccount,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ]),
                  ),
                  ButtonCoppy(content: accountName)
                ],
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                    text: 'Ngân hàng: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: bankName,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F8FD),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nội dung chuyển khoản:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                        text: '${invoice?.code ?? ''} - ',
                        children: [TextSpan(text: invoice?.name ?? '')]),
                  ),
                  ButtonCoppy(content: accountName)
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Vui lòng copy đúng nội dung chuyển khoản để nhận ra giao dịch của bạn.',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class ButtonCoppy extends StatelessWidget {
  final String content;
  const ButtonCoppy({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Clipboard.setData(ClipboardData(text: content)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$content đã được thêm vào bảng nhớ")));
        });
      },
      child: Row(
        children: const [
          Icon(Icons.file_copy_sharp, color: Color(0xFF00948C)),
          Text('Coppy', style: TextStyle(color: Color(0xFF00948C)))
        ],
      ),
    );
  }
}
