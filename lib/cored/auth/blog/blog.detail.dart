import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:share/share.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'blog.detail.controller.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogDetailController blogDetailController =
      Get.put(BlogDetailController());

  BlogDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Obx(() => blogDetailController.blog.value.id != null
                ? GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                    ))
                : const SizedBox())
          ],
          title: Obx(() => Text(blogDetailController.blog.value.title ?? '')),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Obx(
          () => blogDetailController.blog.value.id == null
              ? Container()
              : Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              blogDetailController.blog.value.imageUrl),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(blogDetailController.blog.value.title ?? '',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyText1!
                                .copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                            'Ngày ${Convert.stringToDateAnotherPattern(blogDetailController.blog.value.createdAt ?? '', patternIn: 'yyyy-MM-ddThh:mm:ss', patternOut: 'dd/MM/yyyy, hh:mm:ss')}',
                            softWrap: true,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: const Color(0xFF6F7993))),
                        const SizedBox(
                          height: 16,
                        ),
                        HtmlWidget(
                          blogDetailController.blog.value.content ?? '',
                          webView: true,
                          webViewJs: true,
                        ),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  )),
        ));
  }
}
