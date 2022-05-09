import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/text.form.widget.dart';

import 'confirmOTP.controller.dart';

class ConfirmOTPForm extends GetView {
  @override
  final ConfirmOTPController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OTPField(onSend: (text) {
              print(text);
              controller.confirmOTPTextController!.text = text;
              controller.confirmOTP();
            }),
            const SizedBox(
              height: 16.0,
            ),
            BigButton(
              borderRadius: BorderRadius.circular(16),
              function: () {
                if (controller.key.currentState!.validate()) {
                  controller.confirmOTP();
                }
              },
              text: 'Xác nhận',
            ),
            const SizedBox(
              height: 16.0,
            ),
            Obx(
              () => controller.time.value == 0
                  ? GestureDetector(
                      onTap: () {
                        controller.resetOTP();
                      },
                      child: Text.rich(
                        TextSpan(text: 'Bạn không nhận được mã ?', children: [
                          TextSpan(
                            text: ' Gửi lại OTP',
                            style: Get.textTheme.bodyText2!
                                .copyWith(color: const Color(0xFFFDB913)),
                          )
                        ]),
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : Text.rich(
                      TextSpan(
                          text: 'Vui lòng đợi ',
                          style: const TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: '${controller.time.value} ',
                              style: Get.textTheme.bodyText2!
                                  .copyWith(color: const Color(0xFFFDB913)),
                            ),
                            const TextSpan(text: 'giây để gửi lại')
                          ]),
                      style: Get.textTheme.bodyText2!
                          .copyWith(color: Colors.white),
                    ),
            ),
          ],
        ));
  }
}

class OTPField extends StatelessWidget {
  final Function(String) onSend;
  List<FocusNode> focusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  List<TextEditingController> editingController = [
    TextEditingController()..text = ' ',
    TextEditingController()..text = ' ',
    TextEditingController()..text = ' ',
    TextEditingController()..text = ' ',
    TextEditingController()..text = ' ',
    TextEditingController()..text = ' ',
  ];

  OTPField({Key? key, required this.onSend}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextOTP(
              function: () {
                check(0);
              },
              next: () {
                next(0);
              },
              back: () {
                editingController[0].text = ' ';
                editingController[0].selection = TextSelection.fromPosition(
                    TextPosition(offset: editingController[0].text.length));
              },
              fillAll: fillAllText,
              controller: editingController[0],
              focusNode: focusNode[0]),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextOTP(
              function: () {
                check(1);
              },
              back: () {
                back(1);
              },
              next: () {
                next(1);
              },
              fillAll: fillAllText,
              controller: editingController[1],
              focusNode: focusNode[1]),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextOTP(
          function: () {
            check(2);
          },
          back: () {
            back(2);
          },
          next: () {
            next(2);
          },
          fillAll: fillAllText,
          controller: editingController[2],
          focusNode: focusNode[2],
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextOTP(
            function: () {
              check(3);
            },
            back: () {
              back(3);
            },
            next: () {
              next(3);
            },
            fillAll: fillAllText,
            controller: editingController[3],
            focusNode: focusNode[3],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextOTP(
            function: () {
              check(4);
            },
            back: () {
              back(4);
            },
            next: () {
              next(4);
            },
            fillAll: fillAllText,
            controller: editingController[4],
            focusNode: focusNode[4],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextOTP(
            function: () {
              check(5);
            },
            back: () {
              back(5);
            },
            fillAll: fillAllText,
            controller: editingController[5],
            focusNode: focusNode[5],
          ),
        )
      ],
    );
  }

  void check(int i) {
    var stringSend = '';
    for (var controller in editingController) {
      if (controller.text.length == 1) {
        focusNode[editingController.indexOf(controller)].requestFocus();
        return;
      }
      stringSend = '$stringSend${controller.text.trim()}';
    }
    onSend(stringSend);
  }

  fillAllText(String text) {
    for (var element in editingController) {
      element.text = text[editingController.indexOf(element)];
    }
    onSend(text);
  }

  void back(int i) {
    if (i > 0) {
      editingController[i].text = ' ';
      focusNode[i - 1].requestFocus();
      editingController[i - 1].selection = TextSelection.fromPosition(
          TextPosition(offset: editingController[i - 1].text.length));
    }
  }

  void next(int i) {
    var charactor =
        editingController[i].text[editingController[i].text.length - 1];
    editingController[i].text = editingController[i]
        .text
        .substring(0, editingController[i].text.length - 1);
    editingController[i + 1].text = ' $charactor';
    focusNode[i + 1].requestFocus();
    editingController[i + 1].selection = TextSelection.fromPosition(
        TextPosition(offset: editingController[i + 1].text.length));
    if (i == 4) {
      var stringSend = '';
      for (var controller in editingController) {
        if (controller.text.length == 1) {
          focusNode[editingController.indexOf(controller)].requestFocus();
          return;
        }
        stringSend = '$stringSend${controller.text.trim()}';
      }
      onSend(stringSend);
    }
  }
}

class TextOTP extends StatelessWidget {
  final Function? function;
  final Function? next;
  final Function(String text)? fillAll;
  final FocusNode focusNode;
  final Function? back;
  final TextEditingController controller;

  const TextOTP(
      {Key? key,
      this.function,
      required this.focusNode,
      required this.controller,
      this.fillAll,
      this.back,
      this.next})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          counterText: "",
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
      onChanged: (text) {
        if ((text.isEmpty) && back != null) {
          back!();
        }
        if (function != null && text.length == 2) {
          function!();
        }
        if (next != null && text.length == 3) {
          next!();
        }
        if (text.length == 7 && fillAll != null) {
          fillAll!(text);
        }
      },
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
    );
  }
}
