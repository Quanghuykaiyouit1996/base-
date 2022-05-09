import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/review.model.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/decorate.bottom.appbar.dart';
import 'package:base/widgets/image.product.dart';

import 'review.controller.dart';

class ReviewPage extends StatelessWidget {
  final controller = Get.put(ReviewController());

  ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Đánh giá của tôi'),
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
                tabs: const [Text('Phòng'), Text('Quản lý tòa nhà')],
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
        backgroundColor: Color(0xFFF5F8FD),
        body: Obx(() => CustomList(
              scrollDirection: Axis.vertical,
              mainAxisCount: 1,
              borderRadius: 6,
              scrollController: controller.scrollController,
              widthItem: Get.size.width - 32,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              mainSpace: 10,
              crossSpace: 10,
              onClickItem: (index) async {
                await Get.toNamed(Routes.REVIEWDETAIL,
                    arguments: controller.reviews[index].id);
                controller.getReviews();
              },
              itemCount: controller.reviews.length,
              customWidget: (index) => controller.reviews[index].targetType ==
                      ReviewType.building.toShortString()
                  ? InfoReviewBuilding(review: controller.reviews[index])
                  : InfoReviewRoom(review: controller.reviews[index]),
            )));
  }
}

class InfoReviewRoom extends StatelessWidget {
  final Review review;

  const InfoReviewRoom({
    Key? key,
    required this.review,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var room = review.room;
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ImageProductInRow(
            imageUrl: review.image,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${room?.name ?? ''} - ${room?.building?.name ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 4,
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
                  tapOnlyMode: false,
                  ignoreGestures: true,
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(review.content ?? '')
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Icon(MyFlutterApp.right_open)
        ],
      ),
    );
  }
}

class InfoReviewBuilding extends StatelessWidget {
  final Review review;

  const InfoReviewBuilding({
    Key? key,
    required this.review,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var building = review.building;
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1E9EC),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ImageProductInRow(
            imageUrl: review.image,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(building?.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 4,
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
                  tapOnlyMode: false,
                  ignoreGestures: true,
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(review.content ?? '')
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Icon(MyFlutterApp.right_open)
        ],
      ),
    );
  }
}
