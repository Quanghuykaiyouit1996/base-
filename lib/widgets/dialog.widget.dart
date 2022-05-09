import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/main.dart';
import 'package:mobile_admin/utils/icon/custom.icon.dart';

import 'button.widget.dart';

class CustomSuccessDialog extends StatelessWidget {
  final Function function;
  final String title;
  final String description;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final String textButton;

  const CustomSuccessDialog({
    required this.function,
    required this.title,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    required this.description,
    this.textButton = 'Đóng',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          constraints: BoxConstraints(minHeight: 100),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Get.textTheme.subtitle2!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    description,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.subtitle2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SmallButton(
                iconSize: const Size(150, 40),
                text: textButton,
                function: function,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomWarningDialog extends StatelessWidget {
  final Function function;
  final String title;
  final String description;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final String textButton;

   const CustomWarningDialog({
    required this.function,
    required this.title,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    required this.description,
    this.textButton = 'Đóng',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Get.textTheme.subtitle2!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    description,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.subtitle2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SmallButton(
                iconSize: const Size(150, 40),
                text: textButton,
                function: function,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomFailDialog extends StatelessWidget {
  final Function function;
  final String title;
  final String description;
  final Color textColor;
  final Color splashColor;
  final String? contentButton;
  final double fontSize;

  const CustomFailDialog({
    required this.function,
    required this.title,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    required this.description,
    this.contentButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            constraints: BoxConstraints(minHeight: 100),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Expanded(
                //     flex: 4,
                //     child: Transform.rotate(
                //       angle: math.pi / 4,
                //       child: Icon(
                //         Icons.add_circle,
                //         color: Colors.red,
                //         size: 70,
                //       ),
                //     )),
                // SizedBox(height: 12),
                Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.subtitle2,
                ),
                const SizedBox(height: 8),
                Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyText2,
                      ),
                    )),
                const SizedBox(height: 16),
                SmallButton(
                  iconSize: Size(150, 40),
                  text: contentButton ?? 'Đóng',
                  function: function,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomChooseDialog extends StatelessWidget {
  final Function acceptFunction;
  final Function closeFunction;
  final bool hasCloseButton;
  final bool disAbleCloseButton;
  final String title;
  final String description;
  final Color textColor;
  final bool? hasClose;
  final Color splashColor;
  final String? titleCloseButton;
  final String? titleAcceptButton;
  final String? contentCloseButton;
  final String? contentAcceptButton;
  final double fontSize;

  const CustomChooseDialog({
    required this.acceptFunction,
    required this.closeFunction,
    required this.title,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.textColor = Colors.white,
    required this.description,
    this.contentCloseButton,
    this.contentAcceptButton,
    this.hasClose,
    this.titleCloseButton,
    this.titleAcceptButton,
    this.hasCloseButton = true,
    this.disAbleCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 45),
              constraints: const BoxConstraints(minHeight: 100),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (hasClose ?? false)
                        const Icon(
                          MyFlutterApp.cancel,
                          color: Colors.transparent,
                        ),
                      Expanded(
                        child: Text(
                          title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                      if (hasClose ?? false)
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(MyFlutterApp.cancel),
                        )
                    ],
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            description,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyText2,
                          ),
                        )),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          if (titleCloseButton != null) ...[
                            Text(titleCloseButton!),
                            const SizedBox(
                              height: 6,
                            )
                          ],
                          hasCloseButton
                              ? SmallButton(
                                  iconSize: const Size(100, 30),
                                  text: contentCloseButton ?? 'Đóng',
                                  function: disAbleCloseButton
                                      ? () {}
                                      : closeFunction,
                                  textColor: const Color(0xFF9D9BC9),
                                  color: Colors.white,
                                  border: const BorderSide(
                                      color: Color(0xFF9D9BC9)))
                              : SmallButton(
                                  iconSize: const Size(100, 30),
                                  text: contentCloseButton ?? 'Đóng',
                                  function: disAbleCloseButton
                                      ? () {}
                                      : closeFunction,
                                  textColor: !disAbleCloseButton
                                      ? Colors.white
                                      : const Color(0xFF00948C),
                                  color: !disAbleCloseButton
                                      ? Get.theme.primaryColor
                                      : const Color(0xFF00948C)
                                          .withOpacity(0.2),
                                ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          if (titleAcceptButton != null) ...[
                            Text(titleAcceptButton!),
                            const SizedBox(
                              height: 6,
                            )
                          ],
                          SmallButton(
                            iconSize: const Size(100, 30),
                            text: contentAcceptButton ?? 'Đồng ý',
                            function: acceptFunction,
                            textColor: Colors.white,
                            color: Get.theme.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
