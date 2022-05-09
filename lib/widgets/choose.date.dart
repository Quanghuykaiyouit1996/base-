import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/utils/helpes/convert.dart';

class ChooseDate extends StatelessWidget {
  final RxString textDate;
  final bool enable;
  const ChooseDate({Key? key, required this.textDate, this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!enable) {
          return;
        }
        var picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1000, 1),
            lastDate: DateTime.now());

        if (Convert.dateToString(picked, 'dd/MM/yyyy') != textDate.value) {
          textDate.value = Convert.dateToString(picked, 'dd/MM/yyyy');
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.only(top: 1, left: 1, right: 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              color: enable ? Colors.white : Colors.grey.withOpacity(0.3)),
          child: Row(
            children: [
              Expanded(
                  child: Obx(() => Text(
                        textDate.isEmpty ? 'Ngày cấp' : textDate.value,
                        style: TextStyle(
                            color: textDate.isEmpty
                                ? Get.theme.hintColor
                                : Colors.black),
                      ))),
              Icon(
                Icons.calendar_today,
                size: 12,
              )
            ],
          )),
    );
  }
}
