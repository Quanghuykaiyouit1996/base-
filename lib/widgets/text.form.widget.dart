import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormFieldLogin extends StatelessWidget {
  final Function? validator;
  final void Function()? onTap;
  final String hintText;
  final TextEditingController? controller;
  final Color color;
  final Color textColor;
  final Function(String text)? onFieldSubmitted;
  final Color splashColor;
  final double fontSize;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final RxBool isFail = false.obs;
  final int maxLines;
  final bool hasIcon;
  final bool enable;
  final bool hasPrefixIcon;
  final IconData? prefixIcon;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final InputBorder? border;
  final bool obscureText;
  final BorderRadius? borderRadiusOut;
  final AutovalidateMode? autoValidate;

  TextFormFieldLogin(
      {Key? key,
      this.splashColor = Colors.blueGrey,
      this.fontSize = 4,
      this.color = Colors.white,
      this.textColor = Colors.white,
      this.hintText = '',
      this.validator,
      required this.controller,
      this.keyboardType,
      this.maxLines = 1,
      this.focusNode,
      this.contentPadding,
      this.initialValue,
      this.hasIcon = true,
      this.enable = true,
      this.border,
      this.autoValidate,
      this.hasPrefixIcon = false,
      this.prefixIcon,
      this.onTap,
      this.obscureText = false,
      this.borderRadiusOut,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadiusOut,
          color: color,
        ),
        child: TextFormField(
          cursorHeight: 13,
          keyboardType: keyboardType,
          maxLines: maxLines,
          focusNode: focusNode,
          initialValue: initialValue,
          obscureText: obscureText,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap ?? () {},
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF797C8D)),
              fillColor: const Color(0xFFFFFFFF),
              filled: true,
              enabled: enable,
              isCollapsed: true,
              disabledBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              enabledBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              focusedBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              prefixIcon: hasPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 8),
                      child:
                          Icon(prefixIcon ?? Icons.phone, color: Colors.orange),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 50, maxWidth: 500),
              suffixIcon: hasIcon
                  ? Obx(() => isFail.value
                      ? const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.warning_amber_outlined,
                              color: Colors.orange),
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ))
                  : null,
              errorStyle: const TextStyle(
                color: Colors.orange,
              ),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 50, maxWidth: 50),
              errorBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.orange)),
              focusedErrorBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.orange)),
              contentPadding: contentPadding ??
                  const EdgeInsets.fromLTRB(15.0, 10, -30, 10),
              border: InputBorder.none),
          controller: controller,
          validator: (String? text) {
            if (validator == null) return null;
            String? errorText = validator!(text);
            isFail.value = (errorText != null);
            return errorText;
          },
          autovalidateMode: autoValidate ?? AutovalidateMode.onUserInteraction,
        ));
  }
}

class TextFormFieldUnit extends StatelessWidget {
  final Function? validator;
  final String hintText;
  final TextEditingController? controller;
  final Color color;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final RxBool isFail = false.obs;
  final int maxLines;
  final bool enable;
  final String unit;
  final Function(String text)? onChanged;
  final Function(String text)? onFieldSubmitted;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final Color? borderColor;
  final Color? fillColor;
  final InputBorder? border;
  final bool obscureText;
  final bool isCollapsed;
  final AutovalidateMode? autoValidate;

  TextFormFieldUnit({
    Key? key,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.hintText = '',
    this.validator,
    required this.controller,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
    this.focusNode,
    this.contentPadding,
    this.initialValue,
    this.enable = true,
    this.border,
    this.obscureText = false,
    this.autoValidate,
    this.isCollapsed = true,
    this.borderColor,
    this.fillColor,
    this.onFieldSubmitted,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: TextFormField(
          cursorHeight: 14,
          keyboardType: keyboardType,
          maxLines: maxLines,
          focusNode: focusNode,
          initialValue: initialValue,
          obscureText: obscureText, // passwordText
          enabled: enable,
          style: const TextStyle(fontSize: 12),
          onChanged: onChanged,
          enableInteractiveSelection: true,
          autofocus: false,
          readOnly: false,
          onFieldSubmitted: onFieldSubmitted,
          toolbarOptions: const ToolbarOptions(
              paste: true, cut: true, selectAll: true, copy: true),
          decoration: InputDecoration(
              isCollapsed: isCollapsed, // heightBackground
              hintText: hintText,
              fillColor: fillColor ?? Colors.white,
              filled: true,
              enabled: enable,
              disabledBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              enabledBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              focusedBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFFE1E9EC))),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 36, minHeight: 36),
              suffixIcon: Container(
                width: 30,
                margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color(0xFFEDF1F5),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(4.0))),
                child: Text(
                  unit,
                  style: const TextStyle(
                      color: Color(0xFF7C7BAD),
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
              errorBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: border ??
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.red)),
              contentPadding:
                  contentPadding ?? const EdgeInsets.fromLTRB(15.0, 11, 0, 0),
              border: InputBorder.none),
          controller: controller,
          validator: (String? text) {
            if (validator == null) return null;
            String? errorText = validator!(text);
            isFail.value = (errorText != null);
            return errorText;
          },
          autovalidateMode: autoValidate ?? AutovalidateMode.onUserInteraction,
        ));
  }
}
