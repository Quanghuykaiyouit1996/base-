import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/blog.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.blog.dart';

import 'blog.controller.dart';

class BlogPage extends StatelessWidget {
  final BlogController blogController = Get.put(BlogController());

  BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: kToolbarHeight,
          title: const Text('Tất cả bài viết'),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => RefreshIndicator(
                  onRefresh: () async {
                    blogController.getBlog();
                  },
                  child: CustomList(
                      scrollController: blogController.controller,
                      shrinkWrap: false,
                      backgroundColor: Colors.transparent,
                      scrollPhysics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      customWidget: (int index) {
                        var blog = blogController.blogs[index];
                        return BlogChildItem(blog: blog);
                      },
                      itemCount: blogController.blogs.length),
                ))));
  }
}

class BlogChildItem extends StatelessWidget {
  final Blog? blog;

  const BlogChildItem({Key? key, this.blog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BLOGDETAIL, arguments: blog);
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: ImageBlogInColumn(imageUrl: blog!.imageUrl)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5, right: 5, left: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blog?.title ?? '',
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w700)),
                  Text(Utilities.parseHtmlString(blog?.content ?? ''),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.headline5!
                          .copyWith(color: Color(0xFF6F7993))),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                        'Ngày ${Convert.stringToDateAnotherPattern(blog?.createdAt ?? '', patternIn: 'yyyy-MM-ddThh:mm:ss', patternOut: 'dd/MM/yyyy hh:mm:ss')}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.headline5),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
