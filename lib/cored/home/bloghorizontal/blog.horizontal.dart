import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/blog.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/title.collection.dart';

import 'blog.horizontal.controller.dart';

class BlogHorizotalPage extends StatelessWidget {
  final BlogHorizontalController controller;
  final widthOneChild = (Get.size.width - 20) * 2 / 3;
  final heightChild = 0;
  final double heightTitle = 35;

  final String? title;

  BlogHorizotalPage({Key? key, this.title, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightImage = (widthOneChild - 16) * 125 / 220;
    var heightTitleBlog = (Get.textTheme.headline5!.fontSize ?? 0) * 1.0 * 2;
    var heightTimeBlog = (Get.textTheme.headline5!.fontSize ?? 0) * 1.0;
    var heightChild =
        heightTitle + heightImage + heightTitleBlog + heightTimeBlog;
    return Obx(() => controller.blogs.isEmpty
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            height: heightChild + heightTitle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: heightTitle,
                  width: double.infinity,
                  child: TitleMainComponanet(
                    hasViewMore: true,
                    onViewAll: () {
                      controller.viewAll();
                    },
                    title: controller.itemModule?.title ?? 'Tin tức',
                  ),
                ),
                Expanded(
                  child: Obx(() => CustomList(
                        scrollDirection: Axis.horizontal,
                        mainAxisCount: 1,
                        borderRadius: 6,
                        widthItem: widthOneChild,
                        heightItem: heightChild,
                        mainSpace: 10,
                        crossSpace: 10,
                        onClickItem: (index) {
                          Get.toNamed(Routes.BLOGDETAIL,
                              arguments: controller.blogs[index]);
                        },
                        itemCount: controller.blogs.length,
                        customWidget: (index) =>
                            _buildChild(controller.blogs[index], index),
                      )),
                )
              ],
            )));
  }

  Widget _buildChild(Blog blog, int index) {
    return ChildBlogHorizotal(
      blog: blog,
    );
  }
}

class ChildBlogHorizotal extends StatelessWidget {
  final Blog? blog;

  const ChildBlogHorizotal({this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 1),
                blurRadius: 2)
          ],
          borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, snapshot) {
            return SizedBox(
              width: snapshot.constrainWidth(),
              height: snapshot.constrainWidth() * 125 / 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Utilities.getImageNetwork(blog?.imageUrl,
                    fit: BoxFit.cover),
              ),
            );
          }),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 28,
            child: Text(
              blog?.title ?? '',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          // Text(
          //   Utilities.parseHtmlString(blog?.content ?? ''),
          //   style: Get.textTheme.headline5,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Convert.stringToDateAnotherPattern(blog?.publishedAt ?? '',
                patternOut: 'dd/MM/yyyy'),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
