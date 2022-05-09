import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/blog.model.dart';
import 'package:base/models/settings.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.product.dart';
import 'package:base/widgets/title.collection.dart';

class BannerHome extends StatelessWidget {
  final heightComponent = Get.size.height * 6 / 8;
  final double heightTitle = 35;
  final ItemModule item;

  BannerHome(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.imageUrl == null || item.imageUrl!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                  width: Get.size.width - 32,
                  height: (Get.size.width - 32) * 114 / 343,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.BLOGDETAIL,
                          arguments: Blog(id: item.value));
                    },
                    child: Image.network(
                      item.imageUrl ?? '',
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
          );
  }
}
