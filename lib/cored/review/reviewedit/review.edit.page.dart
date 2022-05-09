import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:base/cored/review/reviewdetail/review.detail.page.dart';
import 'package:base/models/review.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.list.dart';
import 'package:base/widgets/text.form.widget.dart';

import 'review.edit.controller.dart';

class ReviewEditPage extends StatelessWidget {
  ReviewEditPage({Key? key}) : super(key: key);

  final controller = Get.put(ReviewEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.reviewRoom.value.id == null ||
                  controller.reviewBuilding.value.id == null
              ? 'Viết đánh giá'
              : 'Chi tiết đánh giá')),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: Obx(() => BigButton(
                  function: () {
                    if (controller.key.currentState?.validate() ?? false) {
                      controller.editReview();
                    }
                  },
                  text: controller.reviewRoom.value.id == null ||
                          controller.reviewBuilding.value.id == null
                      ? 'Gửi đánh giá'
                      : 'Sửa đánh giá',
                ))),
        body: Form(
          key: controller.key,
          child: SingleChildScrollView(
            child: GetBuilder<ReviewEditController>(
                initState: (_) {},
                builder: (_) {
                  var reviewRoom = controller.reviewRoom.value;
                  var reviewBuilding = controller.reviewBuilding.value;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (controller.roomID != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ReviewInfo(
                                review: reviewRoom,
                                ratingValue: controller.ratingRoom,
                                textController: controller.reviewRoomController,
                                listImageController:
                                    controller.imageRoomController),
                          ),
                          const Divider(height: 32)
                        ],
                        if (controller.buildingID != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ReviewInfo(
                                review: reviewBuilding,
                                ratingValue: controller.ratingBuilding,
                                textController:
                                    controller.reviewBuildingController,
                                listImageController:
                                    controller.imageBuildingController),
                          ),
                      ]);
                }),
          ),
        ));
  }
}

class ReviewInfo extends StatelessWidget {
  final Review review;
  final Rx<double> ratingValue;
  final TextEditingController textController;
  final ImageListController listImageController;

  const ReviewInfo(
      {Key? key,
      required this.review,
      required this.ratingValue,
      required this.textController,
      required this.listImageController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Đánh giá ${review.type.toTypeString().toLowerCase()}'),
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
          itemSize: 30,
          onRatingUpdate: (rating) {
            ratingValue.value = rating;
          },
        ),
        const SizedBox(
          height: 4,
        ),
        Obx(() => Text(Utilities.getRatingComment(ratingValue.value),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hình ảnh',
                    style: TextStyle(color: Color(0xFF9D9BC9))),
                GestureDetector(
                  onTap: () {
                    listImageController.uploadImage(false, context);
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
            Obx(() => listImageController.imagesLink.isEmpty
                ? ButtonAddImage(
                    controllerImage: listImageController,
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ImageList(
                      controller: listImageController,
                      type: TypeImageList.scrollhorizontal,
                    ),
                  )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormFieldLogin(
          controller: textController,
          maxLines: 6,
          hintText: 'Nhập nội dung nhận xét của bạn \n(Tối đa 4000 ký tự)',
          validator: (String value) {
            if (value.isEmpty) {
              return 'Hãy nhập gì đấy để nhận xét';
            } else if (value.length > 4000) {
              return 'Chỉ được nhập tối đa 4000 ký tự';
            }
            return null;
          },
        )
      ],
    );
  }
}
