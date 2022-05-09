import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/address.model.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/customer.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/component.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.blog.dart';
import 'package:base/widgets/image.list.dart';
import 'package:base/widgets/image.product.dart';

import 'contract.detail.controller.dart';

class ContractDetailPage extends StatelessWidget {
  final controller = Get.put(ContractDetailController());

  ContractDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.contract.value.code ?? '')),
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE1E9EC)))),
            child: Obx(() => controller.contract.value.isValidate() &&
                    controller.canExtend.value
                ? BigButton(
                    function: () {
                      Get.toNamed(Routes.CONTRACTRENEWAL,
                          arguments: controller.contract.value.id);
                    },
                    color: Get.theme.primaryColorLight,
                    text: 'Gia hạn',
                  )
                : const SizedBox.shrink())),
        body: SingleChildScrollView(
          child: GetBuilder<ContractDetailController>(
              initState: (_) {},
              builder: (_) {
                return Column(
                  children: [
                    Component(
                      widgetChild: BaseInfo(),
                      index: 1,
                      title: 'Thông tin thuê phòng',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: PaymentInfo(),
                      index: 2,
                      title: 'Thời hạn và chu kỳ thanh toán',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: CustomerInfo(),
                      index: 3,
                      title: 'Thông tin người ký hợp đồng',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: AnotherCustomersInfo(),
                      index: 4,
                      title: 'Danh sách người ở',
                    ),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    const Divider(color: Color(0xFFE1E9EC), height: 1),
                    Component(
                      widgetChild: NoteInfo(),
                      index: 5,
                      title: 'Ghi chú',
                    ),
                    const SizedBox(height: 16),
                    Component(
                      widgetChild: HandOverInfo(),
                      index: 6,
                      title: 'Thông tin bàn giao',
                    ),
                    Component(
                      widgetChild: ImagecontractInfo(),
                      index: 7,
                      title: 'Hình ảnh hợp đồng và biên bản',
                    ),
                    const SizedBox(height: 16),
                    Component(
                      widgetChild: InvoiceInfo(),
                      index: 8,
                      title: 'Hóa đơn',
                    ),
                  ],
                );
              }),
        ));
  }
}

class InvoiceInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  InvoiceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contract = controller.contract.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        BigButton(
          function: () {
            Get.toNamed(Routes.CONTRACTINVOICE, arguments: contract.id);
          },
          text: 'Danh sách hóa đơn',
          evelation: 0,
          textColor: Get.theme.primaryColorLight,
          color: Colors.white,
          border: BorderSide(color: Get.theme.primaryColorLight),
        ),
      ],
    );
  }
}

class HandOverInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  HandOverInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contract = controller.contract.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
              text: 'Trạng thái: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: contract.statusHandOover.toShortString() ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: contract.statusHandOover.getColorString()),
                )
              ]),
        ),
        const SizedBox(height: 8),
        if ((contract.statusHandOover == ContractStatusHandOver.receiveRoom ||
                contract.statusHandOover ==
                    ContractStatusHandOver.checkOutRoom) &&
            controller.imagesReceiveRoomLink.isNotEmpty) ...[
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Text('Hình ảnh bàn giao', style: TextStyle(color: Colors.green))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ImageList(
            controller: controller.imageReceiveRoomController,
            justShow: true,
          ),
        ],
        if (contract.statusHandOover == ContractStatusHandOver.checkOutRoom &&
            controller.imagesCheckOutRoomLink.isNotEmpty) ...[
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              Text('Hình ảnh trả phòng', style: TextStyle(color: Colors.green))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ImageList(
            controller: controller.imageCheckoutRoomController,
            justShow: true,
          ),
        ],
        const SizedBox(height: 8),
        BigButton(
          function: () {
            Get.toNamed(Routes.ROOMDETAIL,
                arguments: [contract.roomId, contract.building]);
          },
          text: 'Danh sách tài sản',
          evelation: 0,
          textColor: Get.theme.primaryColorLight,
          color: Colors.white,
          border: BorderSide(
            color: Get.theme.primaryColorLight,
          ),
        ),
      ],
    );
  }
}

class AnotherCustomersInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  AnotherCustomersInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customers = controller.contract.value.customers;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomList(
        itemCount: customers?.length ?? 0,
        customWidget: (index) {
          return RentCustomer(customers![index]);
        },
        mainSpace: 3,
        padding: const EdgeInsets.all(3),
        backgroundColor: const Color(0xFFF5F8FD),
      ),
    );
  }
}

class RentCustomer extends StatelessWidget {
  final Customers customer;
  final RxBool isShow = false.obs;
  RentCustomer(this.customer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 58,
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              isShow.value = !isShow.value;
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ImageProductInRow(
                    imageUrl: customer.photoUrl,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.name ?? ''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(customer.phoneNumber ?? ''),
                          Obx(() => isShow.value
                              ? Row(
                                  children: const [
                                    Text('Ẩn thông tin',
                                        style: TextStyle(
                                            color: Color(0xFF00948C),
                                            fontWeight: FontWeight.w600)),
                                    Icon(MyFlutterApp.down_open,
                                        color: Color(0xFF00948C))
                                  ],
                                )
                              : Row(
                                  children: const [
                                    Text('Hiện thông tin',
                                        style: TextStyle(
                                            color: Color(0xFF00948C),
                                            fontWeight: FontWeight.w600)),
                                    Icon(MyFlutterApp.down_open,
                                        color: Color(0xFF00948C))
                                  ],
                                ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(() => isShow.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Email: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: customer.email ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                                text: 'Ngày sinh: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: Convert.stringToDateAnotherPattern(
                                        customer.dob ?? '',
                                        patternIn: 'yyyy-MM-dd',
                                        patternOut: 'dd/MM/yyyy'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                                text: 'Giới tính: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: customer.getGen(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'CMND/CCCD: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: customer.ssn ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                                text: 'Loại xe: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: customer.vehicleKind ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                                text: 'Hãng xe: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: customer.vehicleVendor ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'Biển kiểm soát: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: customer.vehicleLicensePlate ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink())
      ],
    );
  }
}

class CustomerInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  CustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customer = controller.contract.value.customer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text.rich(
          TextSpan(
              text: 'Tên: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: customer?.name ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Số điện thoại: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: customer?.phoneNumber ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Email: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: customer?.email ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Ngày sinh: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Convert.stringToDateAnotherPattern(
                            customer?.dob ?? '',
                            patternOut: 'dd/MM/yyyy'),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Giới tính: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: customer?.getGen() ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'CMND/CCCD: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: customer?.ssn ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Loại xe: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: customer?.vehicleKind ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Hãng xe: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: customer?.vehicleVendor ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Biển kiểm soát: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: customer?.vehicleLicensePlate ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
      ],
    );
  }
}

class PaymentInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  PaymentInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var contract = controller.contract.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Ngày bắt đầu: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Convert.stringToDateAnotherPattern(
                            contract.startAt ?? '',
                            patternOut: 'dd/MM/yyyy'),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Ngày kết thúc: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Convert.stringToDateAnotherPattern(
                            contract.endAt ?? '',
                            patternOut: 'dd/MM/yyyy'),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Chu kỳ thanh toán (tháng): ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: contract.billingCycle?.toStringAsFixed(0) ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Ngày chốt tiền phòng: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: Convert.getDateMonth(contract.billingCycle),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Hạn thanh toán tiền phòng: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: Convert.getDateMonth(contract.billingDueDay),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                const TextSpan(
                  text: ' (hàng tháng)',
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
      ],
    );
  }
}

class NoteInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  NoteInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(controller.contract.value.note ?? '')],
      ),
    );
  }
}

class ImagecontractInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  ImagecontractInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, constrant) {
          var distanceItem = 6.0;
          var width = (constrant.constrainWidth() - 12) / 3;
          return Wrap(
            alignment: WrapAlignment.start,
            spacing: distanceItem,
            runSpacing: distanceItem,
            children: controller.contract.value.images
                    ?.map((e) => GestureDetector(
                          onTap: () {
                            Utilities.showImage(e);
                          },
                          child: SizedBox(
                              height: width,
                              width: width,
                              child: Utilities.getImageNetwork(e)),
                        ))
                    .toList() ??
                [],
          );
        }),
      ],
    );
  }
}

class BaseInfo extends StatelessWidget {
  final controller = Get.find<ContractDetailController>();

  BaseInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var contract = controller.contract.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Nhà',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE1E9EC),
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: ImageBlogInRow(
                    imageUrl: contract.building?.firstImage,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contract.building?.name ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            height: 16 / 12,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(Utilities.getAddress(
                        contract.building?.address ?? AddressModel())),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                          text: 'Diện tích sàn: ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text:
                                  contract.building?.totalArea.toString() ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            const TextSpan(
                              text: ' m2',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                  ],
                ))
              ],
            )),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Loại phòng: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: contract.room?.type ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Tầng: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: contract.room?.floor?.toStringAsFixed(0) ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: 'Phòng: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: contract.room?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Giá: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: Convert.convertMoney(contract.room?.minPrice),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                const TextSpan(
                  text: '/tháng',
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
              text: 'Tiền cọc thuê phòng: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: Convert.convertMoney(contract.depositAmount),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ]),
        ),
        if (contract.statusAll == ContractStatus.effect ||
            contract.statusAll == ContractStatus.deadline) ...[
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Đánh giá dịch vụ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Gửi tới chúng mình những đánh giá để TingTong hoàn thiện hơn mỗi ngày nhé!',
            style: TextStyle(fontSize: 14, height: 20 / 14),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 170,
            child: BigButton(
              function: () {
                controller.review();
              },
              text: 'Gửi đánh giá',
              color: Colors.white,
              isIconFront: false,
              space: 4,
              evelation: 0,
              icon:
                  const Icon(MyFlutterApp.ic_rating, color: Color(0xFFFDB913)),
              border: const BorderSide(color: Color(0xFFFDB913)),
              textColor: const Color(0xFFFDB913),
            ),
          )
        ]
      ],
    );
  }
}
