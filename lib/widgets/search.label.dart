import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import '../config/pages/app.page.dart';

class SearchLabel extends StatelessWidget {
  final Color? colorSearch;
  final Color? colorHint;
  final BoxDecoration? decoration;
  final AuthController authController = Get.find(tag: 'authController');

  SearchLabel({Key? key, this.colorSearch, this.colorHint, this.decoration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SEARCH);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: kToolbarHeight - 20,
        decoration: decoration ??
            BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color(0xFFF2F4FB)),
        child: Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            Icon(
              Icons.search,
              color: colorSearch ?? const Color(0xFF797C8D),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              'Tìm kiếm sản phẩm',
              style: Get.textTheme.bodyText2!
                  .copyWith(color: colorHint ?? const Color(0xFF797C8D)),
            ),
            const Spacer(
              flex: 14,
            ),
          ],
        ),
      ),
    );
  }
}
