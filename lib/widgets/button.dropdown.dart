import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/models/address.model.dart';
import 'package:mobile_admin/utils/icon/custom.icon.dart';

class ButtonDropdownAddress extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final List<LocationDetail>? items;
  final Function? callback;
  final BorderRadius borderRadius;
  final Rx<LocationDetail?>? selectedItem;

  const ButtonDropdownAddress({
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    this.hintText = '',
    this.items = const [],
    this.callback,
    this.selectedItem,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: const EdgeInsets.all(1),
      height: 32,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: borderRadius),
      child: Obx(() => DropdownButton(
            value: selectedItem?.value?.id != null
                ? items!.firstWhereOrNull(
                    (element) => element.id == selectedItem?.value?.id)
                : null,
            onChanged: (LocationDetail? location) {
              selectedItem!.value = location;
              if (callback != null) {
                callback!(location);
              }
            },
            items: items!.map((item) {
              return DropdownMenuItem<LocationDetail>(
                value: item,
                child: Text(item.name!),
              );
            }).toList(),
            hint: Text(
              hintText,
            ),
            underline: const SizedBox(),
            dropdownColor: Colors.white,
            focusColor: Colors.white,
            isExpanded: true,
            icon: const Icon(MyFlutterApp.down_open),
          )),
    );
  }
}

class ButtonDropdown<T> extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final List<T>? items;
  final Function(T value)? callback;
  final bool enable;

  final Rx<T>? selectedItem;
  final List<DropdownMenuItem<T>>? childs;

  const ButtonDropdown({
    Key? key,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    this.hintText = '',
    this.items = const [],
    this.callback,
    this.selectedItem,
    this.childs,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: const EdgeInsets.all(1),
      height: 32,
      decoration: BoxDecoration(
          color: enable ? Colors.white : Colors.grey.withOpacity(0.3),
          border: Border.all(color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(4.0))),
      child: Obx(() => DropdownButton<T>(
                value: selectedItem?.value != null
                    ? items!.firstWhereOrNull(
                        (element) => element == selectedItem?.value)
                    : null,
                onChanged: enable
                    ? (T? value) {
                        selectedItem!.value = value!;
                        if (callback != null) {
                          callback!(value);
                        }
                      }
                    : null,
                items: childs,
                hint: Text(
                  hintText,
                ),
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                focusColor: Colors.white,
                isExpanded: true,
                icon: const Icon(MyFlutterApp.down_open),
                //       child: TextFormField(
                //   onTap: (){

                //   },
              ) //   readOnly: true,
          //   decoration: InputDecoration(
          //       hintStyle: Get.textTheme.bodyText2,
          //       hintText: hintText,
          //       suffixIcon: Icon(Icons.keyboard_arrow_down),
          //       contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          //       border: InputBorder.none),
          // ),
          ),
    );
  }
}
