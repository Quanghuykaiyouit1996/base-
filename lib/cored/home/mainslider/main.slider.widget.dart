import 'package:card_swiper/card_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/settings.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/image.branch.dart';

class BannerSlidderHome extends StatelessWidget {
  final List<ItemModule>? item;
  final AuthController authController = Get.find(tag: 'authController');
  final int? limit;

  BannerSlidderHome({Key? key, required this.item, this.limit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16),
          height: Get.size.width * 114 / 343,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          child: MySlider(
            child: getChild,
            scrollDirection: Axis.horizontal,
            onClickItem: (index) {
              Utilities.goToPageFromBanner(item![index]);
            },
            itemCount: item?.map((itemModel) => itemModel.imageUrl).length ?? 1,
            controller: SwiperController(),
          )),
    );
  }

  Widget getChild(int index) {
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
          top: Radius.circular(16),
        ),
        child: ImageBranchInColumn(imageUrl: item![index].imageUrl));
  }
}

class MySlider extends StatelessWidget {
  final int? itemCount;
  final SwiperController controller;
  final Axis? scrollDirection;
  final Widget Function(int index) child;
  final Function(int index)? onClickItem;
  final SwiperPagination? pagination;

  const MySlider(
      {this.itemCount,
      this.scrollDirection,
      required this.child,
      this.onClickItem,
      required this.controller,
      this.pagination});
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: itemCount ?? 1,
      controller: controller,
      loop: true,
      onIndexChanged: (index) {
        print(index);
      },
      scrollDirection: scrollDirection!,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              if (onClickItem != null) {
                onClickItem!(index);
              }
            },
            child: child(index));
      },
      pagination: pagination ??
          SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10.0),
              builder: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig? config) {
                return DotsIndicator(
                  dotsCount: (config?.itemCount != null &&
                          (config?.itemCount ?? 0) > 0)
                      ? (config?.itemCount ?? 1)
                      : 1,
                  position: config?.activeIndex?.toDouble() ?? 0,
                  decorator: DotsDecorator(
                    activeColor: Get.theme.primaryColor,
                    color: Colors.white,
                    spacing: const EdgeInsets.only(left: 2.0, right: 2.0),
                    size: const Size(12, 6),
                    activeSize: const Size(28, 6),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                );
              })),
    );
  }
}
