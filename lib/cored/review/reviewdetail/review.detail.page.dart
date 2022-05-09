import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:base/constants/Image.asset.dart';
import 'package:base/models/review.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.list.dart';
import 'package:base/widgets/text.form.widget.dart';

import 'review.detail.controller.dart';

class ReviewDetailPage extends StatelessWidget {
  ReviewDetailPage({Key? key}) : super(key: key);

  final controller = Get.put(ReviewDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết đánh giá'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: BigButton(
              function: () {
                if (controller.key.currentState?.validate() ?? false) {
                  controller.editReview();
                }
              },
              text: 'Sửa đánh giá',
            )),
        body: Form(
          key: controller.key,
          child: SingleChildScrollView(
            child: GetBuilder<ReviewDetailController>(
                initState: (_) {},
                builder: (_) {
                  var review = controller.review.value;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Đánh giá ${review.type.toTypeString().toLowerCase()}'),
                          const SizedBox(
                            height: 16,
                          ),
                          RatingBar.builder(
                            initialRating: review.ratingNumber,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.only(right: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              MyFlutterApp.ic_rating,
                              color: Colors.amber,
                            ),
                            wrapAlignment: WrapAlignment.end,
                            itemSize: 15,
                            onRatingUpdate: (rating) {
                              controller.rating.value = rating;
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(() => Text(
                              Utilities.getRatingComment(
                                  controller.rating.value),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Hình ảnh',
                                      style:
                                          TextStyle(color: Color(0xFF9D9BC9))),
                                  GestureDetector(
                                    onTap: () {
                                      controller.imageController
                                          .uploadImage(false, context);
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Row(
                                      children: const [
                                        Icon(MyFlutterApp.plus,
                                            size: 18, color: Color(0xFF00948C)),
                                        SizedBox(width: 4),
                                        Text('Thêm hình ảnh',
                                            style: TextStyle(
                                                color: Color(0xFF00948C),
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Obx(() => controller.imagesLink.isEmpty
                                  ? ButtonAddImage(
                                      controllerImage:
                                          controller.imageController,
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ImageList(
                                        controller: controller.imageController,
                                        type: TypeImageList.scrollhorizontal,
                                      ),
                                    )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormFieldLogin(
                            controller: controller.reviewController,
                            maxLines: 6,
                            hintText:
                                'Nhập nội dung text của bạn \n (Tối đa 4000 ký tự)',
                            validator: controller.reviewValidator,
                          )
                        ]),
                  );
                }),
          ),
        ));
  }
}

class ButtonAddImage extends StatelessWidget {
  final ImageListController controllerImage;
  const ButtonAddImage({Key? key, required this.controllerImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controllerImage.uploadImage(false, context);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFFFF6E9)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ImageAsset.pathAddImage, height: 40, width: 40),
            const SizedBox(width: 16),
            const Expanded(
                child: Text('Thêm hình ảnh nếu bạn muốn',
                    style: TextStyle(color: Color(0xFF9D9BC9))))
          ],
        ),
      ),
    );
  }
}
