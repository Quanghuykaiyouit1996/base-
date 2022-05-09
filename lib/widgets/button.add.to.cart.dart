// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../core/cart/cart.controller.dart';
// import '../core/model/cart.model.dart';
// import '../core/model/collection.model.dart';
// import '../core/model/product.model.dart';
// import '../core/product/product.controller.dart';
// import '../core/product/product.dart';
// import '../core/unfocus.dart';
// import '../utils/custom.icon.dart';
// import 'text.form.widget.dart';

// import 'button.widget.dart';

// class ButtonAddToCart extends StatefulWidget {
//   final Size size;
//   final ProductItem? product;
//   final BorderRadius? borderRadius;
//   final EdgeInsets? padding;

//   ButtonAddToCart(
//       {required this.product,
//       this.size = const Size(140, 45),
//       this.borderRadius,
//       this.padding});

//   @override
//   _ButtonAddToCartState createState() => _ButtonAddToCartState();
// }

// class _ButtonAddToCartState extends State<ButtonAddToCart>
//     with AutomaticKeepAliveClientMixin {
//   late StreamController<Widget> controller;
//   final CartController cartController = Get.find(tag: 'cartController');
//   bool showNumber = false;

//   @override
//   void initState() {
//     super.initState();
//     if (((cartController.getController(widget.product)?.text ?? '0') != '0')) {
//       showNumber = true;
//     }
//     controller = StreamController<Widget>.broadcast();
//     controller.stream.listen((event) {
//       if (event is ConstrainedBox) {
//         showNumber = true;
//       } else {
//         showNumber = false;
//       }
//     });
//     cartController.getController(widget.product)?.addListener(() {
//       var text = cartController.getController(widget.product)?.text;
//       if (text != null &&
//           text.isNotEmpty &&
//           int.tryParse(text) != null &&
//           int.tryParse(text)! > 0 &&
//           !showNumber) {
//         changeChild(false);
//       }
//       if (text != null &&
//           text.isNotEmpty &&
//           int.tryParse(text) != null &&
//           int.tryParse(text) == 0 &&
//           showNumber) {
//         addButton();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return (widget.product?.productVariants?.length ?? 0) > 1
//         ? ButtonTheme(
//             height: 0,
//             child: BigButton(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               text: 'Thêm vào giỏ',
//               fontSize: 12,
//               evelation: 0,
//               function: goToProductPage,
//               space: 4,
//               icon: Icon(
//                 IconCustom.icon_cart,
//                 color: Colors.white,
//                 size: 16,
//               ),
//             ),
//           )
//         : StreamBuilder(
//             builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) =>
//                 AnimatedSwitcher(
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 var tween =
//                     Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0));
//                 return MySlideTransition(
//                     position: tween.animate(animation), child: child);
//               },
//               duration: Duration(milliseconds: 400),
//               reverseDuration: Duration(milliseconds: 400),
//               switchInCurve: Curves.easeIn,
//               switchOutCurve: Curves.easeOut,
//               child: snapshot.data ??
//                   Container(
//                     height: 40,
//                   ),
//             ),
//             initialData: ((cartController.getController(widget.product)?.text ??
//                         '0') !=
//                     '0')
//                 ? ConstrainedBox(
//                     constraints: BoxConstraints.tightFor(height: 40),
//                     child: ChangeCountItemProduct(
//                       autoAddOneCount: false,
//                       inventory: widget.product?.inventory ?? -1,
//                       contentCountPadding: EdgeInsets.only(top: 0, bottom: 5),
//                       item: widget.product,
//                       hasAnimation: false,
//                       decreaseClick: () {
//                         addButton();
//                       },
//                       type: CountItemType.PRODUCT,
//                     ),
//                   )
//                 : ButtonTheme(
//                     height: 0,
//                     child: BigButton(
//                       evelation: 0,
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       text: 'Thêm vào giỏ',
//                       fontSize: 12,
//                       function: () {
//                         changeChild(true);
//                       },
//                       space: 4,
//                       icon: Icon(
//                         Icons.shopping_cart_outlined,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//             stream: controller.stream,
//           );
//   }

//   void addButton() {
//     if (!controller.isClosed) {
//       controller.sink.add(ButtonTheme(
//         height: 0,
//         child: BigButton(
//           evelation: 0,
//           padding: EdgeInsets.symmetric(vertical: 10),
//           text: 'Thêm vào giỏ',
//           fontSize: 12,
//           function: (widget.product?.countVarriant ?? 0) > 1
//               ? goToProductPage
//               : () {
//                   changeChild(true);
//                 },
//           space: 4,
//           icon: Icon(
//             IconCustom.icon_cart,
//             color: Colors.white,
//             size: 16,
//           ),
//         ),
//       ));
//     }
//   }

//   void changeChild(bool autoAdd) {
//     if (!controller.isClosed) {
//       controller.sink.add(ConstrainedBox(
//         constraints: BoxConstraints.tightFor(height: 40),
//         child: ChangeCountItemProduct(
//           autoAddOneCount: autoAdd,
//           inventory: widget.product?.inventory ?? -1,
//           contentCountPadding: EdgeInsets.only(top: 0, bottom: 5),
//           item: widget.product,
//           hasAnimation: false,
//           decreaseClick: () {
//             addButton();
//           },
//           type: CountItemType.PRODUCT,
//         ),
//       ));
//     }
//   }

//   void goToProductPage() {
//     Get.to(
//         ProductPage(
//             product: widget.product,
//             controller: Get.put(ProductController(),
//                 tag: widget.product!.id.toString())),
//         preventDuplicates: false);
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class ButtonAddToCartMini extends StatefulWidget {
//   final ProductItem product;

//   ButtonAddToCartMini({required this.product});

//   @override
//   _ButtonAddToCartMiniState createState() => _ButtonAddToCartMiniState();
// }

// class _ButtonAddToCartMiniState extends State<ButtonAddToCartMini>
//     with AutomaticKeepAliveClientMixin {
//   late StreamController<Widget> controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = StreamController<Widget>();
//   }

//   @override
//   void dispose() {
//     controller.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return ChangeCountItemProduct(
//       inventory: widget.product.inventory ?? 0,
//       contentCountPadding: EdgeInsets.symmetric(vertical: 7),
//       item: widget.product,
//       hasAnimation: false,
//       type: CountItemType.PRODUCT,
//     );
//   }

//   void goToProductPage() {
//     Get.to(
//       () => ProductPage(
//         product: widget.product,
//         controller:
//             Get.put(ProductController(), tag: widget.product.id.toString()),
//       ),
//       preventDuplicates: false,
//     );
//     // Get.toNamed(Routes.PRODUCT, arguments: widget.product);
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class ChangeCountItemVariant extends StatelessWidget {
//   final RxInt count = 0.obs;
//   final int inventory;
//   final EdgeInsets? contentCountPadding;
//   final TextEditingController textController;
//   final dynamic item;
//   final CountItemType type;
//   final double? inconSize;
//   final CartController cartController = Get.find(tag: 'cartController');

//   ChangeCountItemVariant(
//       {this.inventory = 0,
//       this.contentCountPadding,
//       required this.item,
//       required this.type,
//       required this.textController,
//       this.inconSize})
//       : assert(
//             item is Rx<CartItem> || item is Variants || item is ProductItem, '''
//         Just can add a variants or productItem or cartItem to cart
//       ''') {
//     var textCartController = cartController.getController(item);
//     if (textCartController != null) {
//       textController.text = textCartController.text;
//     }
//     textController.addListener(() {
//       count.value = int.tryParse(textController.text) ?? 0;
//     });
//     count.value = int.tryParse(textController.text) ?? 0;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           IgnoreUnfocuser(
//               child: SmallButton(
//             isClickMulti: false,
//             function: decrease,
//             iconSize: Size(23, 23),
//             icon: IconCustom.icon_subtract,
//             fontSize: inconSize ?? 14,
//             textColor: Colors.white,
//             color: Get.theme.primaryColor,
//           )),
//           SizedBox(
//             width: 8.0,
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 23,
//               child: TextFormFieldAddCart(
//                 fontSize: 12,
//                 borderNumberCount: BorderSide.none,
//                 controller: textController,
//                 contentPadding: contentCountPadding,
//                 item: item,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 8.0,
//           ),
//           IgnoreUnfocuser(
//             child: SmallButton(
//               function: increase,
//               isClickMulti: false,
//               iconSize: Size(23, 23),
//               icon: IconCustom.icon_add,
//               fontSize: inconSize ?? 14,
//               textColor: Colors.white,
//               color: Get.theme.primaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void updateCount() {
//     var countTemp = int.tryParse(textController.text) ?? 0;
//     if (countTemp <= inventory || inventory < 0) {
//       count.value = countTemp;
//       textController.text = count.value.toString();
//     } else {
//       textController.text = inventory.toString();
//       Get.defaultDialog(
//           title: 'Thông báo',
//           middleText: 'Sản phẩm vượt quá số lượng trong kho');
//     }
//   }

//   void increase() {
//     var countTemp = count.value + 1;
//     if (countTemp <= inventory || inventory < 0) {
//       count.value = countTemp;
//       textController.text = count.value.toString();
//     } else {
//       Get.defaultDialog(
//           title: 'Thông báo',
//           middleText: 'Sản phẩm vượt quá số lượng trong kho');
//     }
//   }

//   void decrease() {
//     var countTemp = count.value - 1;
//     if (countTemp < 0) {
//       Get.defaultDialog(
//           title: 'Thông báo', middleText: 'Số sản phẩm không thể nhỏ hơn 0');
//     } else {
//       count.value = countTemp;
//       textController.text = count.value.toString();
//     }
//   }
// }

// // ignore: must_be_immutable
// class ChangeCountItemProduct extends StatelessWidget {
//   final RxInt count = 0.obs;
//   final int inventory;
//   bool? isStartClick;
//   final RxInt countWait = 0.obs;
//   final EdgeInsets? contentCountPadding;
//   final EdgeInsets? contentCountMargin;
//   TextEditingController? textController;
//   final dynamic item;
//   final bool? autoAddOneCount;
//   final CountItemType type;
//   final double? inconSize;
//   final bool? hasAnimation;
//   final Function? increaseClick;
//   final Function? decreaseClick;
//   final BorderSide? borderNumberCount;
//   final CartController cartController = Get.find(tag: 'cartController');
//   final FocusNode _focus = FocusNode();
//   final Duration delayTime = Duration(milliseconds: 1000);

//   ChangeCountItemProduct(
//       {this.inventory = 0,
//       this.contentCountPadding,
//       required this.item,
//       required this.type,
//       this.inconSize,
//       this.hasAnimation,
//       this.increaseClick,
//       this.decreaseClick,
//       this.autoAddOneCount,
//       this.borderNumberCount,
//       this.contentCountMargin})
//       : assert(
//             item is Rx<CartItem> || item is Variants || item is ProductItem, '''
//         Just can add a variants or productItem or cartItem to cart
//       ''') {
//     textController = cartController.getController(item);
//     textController?.addListener(() {
//       count.value = int.tryParse(textController?.text ?? '') ?? 0;
//     });
//     count.value = int.tryParse(textController?.text ?? '') ?? 0;
//     isStartClick = true;
//     if (autoAddOneCount != null && autoAddOneCount!) {
//       increase();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minHeight: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//                 child: Obx(
//               () => AnimatedSwitcher(
//                   transitionBuilder:
//                       (Widget child, Animation<double> animation) {
//                     var tween = count.value == 0
//                         ? Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
//                         : Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                     return MySlideTransition(
//                         position: tween.animate(animation), child: child);
//                   },
//                   duration: Duration(milliseconds: 400),
//                   child: ((hasAnimation ?? true)
//                           ? count.value > 0
//                           : count.value > -1)
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IgnoreUnfocuser(
//                                 child: SmallButton(
//                               isClickMulti: false,
//                               function: decrease,
//                               iconSize: Size(23, 23),
//                               icon: IconCustom.icon_subtract,
//                               fontSize: inconSize ?? 14,
//                               textColor: Colors.white,
//                               color: Get.theme.primaryColor,
//                             )),
//                             Expanded(
//                               child: SizedBox(
//                                 height: 23,
//                                 child: Padding(
//                                   padding: contentCountMargin ??
//                                       EdgeInsets.symmetric(horizontal: 8),
//                                   child: TextFormFieldAddCart(
//                                     fontSize: 13,
//                                     focusNode: _focus,
//                                     item: item,
//                                     borderNumberCount: borderNumberCount,
//                                     callback: updateCount,
//                                     controller: textController,
//                                     contentPadding: contentCountPadding,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container()),
//             )),
//             IgnoreUnfocuser(
//               child: SmallButton(
//                 isClickMulti: false,
//                 iconSize: Size(23, 23),
//                 function: increaseClick ?? increase,
//                 icon: IconCustom.icon_add,
//                 fontSize: inconSize ?? 14,
//                 textColor: Colors.white,
//                 color: Get.theme.primaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void updateCount() async {
//     tempCount = count.value;
//     count.value = int.tryParse(textController!.text)!;
//     var isSuccess = await cartController.updateItem(item, count.value);
//     if (isSuccess) {
//     } else {
//       count.value = tempCount;
//       textController?.text = count.value.toString();
//       await Get.defaultDialog(
//           title: 'Thông báo', content: Text('Thêm sản phẩm không thành công'));
//     }
//   }

//   var tempCount;

//   void increase() async {
//     countWait.value++;
//     textController?.text = (int.tryParse(textController!.text)! + 1).toString();
//     if (isStartClick == null || isStartClick!) {
//       tempCount = count.value;
//     }
//     isStartClick = false;
//     var countWaitTemp = countWait.value;
//     Future.delayed(delayTime, () async {
//       if (countWaitTemp == countWait.value) {
//         if (count.value <= inventory || inventory < 0) {
//           var isSuccess = await cartController.updateItem(item, count.value);
//           if (isSuccess) {
//           } else {
//             count.value = tempCount;
//             textController?.text = count.value.toString();
//             await Get.defaultDialog(
//                 title: 'Thông báo',
//                 content: Text('Thêm sản phẩm không thành công'));
//           }
//           countWait.value = 0;
//           isStartClick = true;
//         } else {
//           count.value = tempCount;
//           textController?.text = count.value.toString();
//           isStartClick = true;
//           countWait.value = 0;
//           await Get.defaultDialog(
//               title: 'Thông báo',
//               content: Text('Sản phẩm vượt quá số lượng trong kho'));
//         }
//       }
//     });
//   }

//   void decrease() async {
//     countWait.value++;
//     if (isStartClick == null || isStartClick!) {
//       tempCount = count.value;
//     }
//     textController?.text = (int.tryParse(textController!.text)! - 1).toString();
//     if (count.value < 0) {
//       await Get.defaultDialog(
//           title: 'Thông báo', middleText: 'Số sản phẩm không thể nhỏ hơn 0');
//     } else {
//       isStartClick = false;

//       if (count.value == 0) {
//         if (item is Rx<CartItem>) {
//           var isChange = false;
//           await Get.defaultDialog(
//               radius: 5,
//               title: 'Cảnh báo',
//               titleStyle: Get.textTheme.bodyText1!
//                   .copyWith(fontWeight: FontWeight.bold),
//               middleText: 'Bạn có chắc muốn xoá sản phẩm này?',
//               middleTextStyle: Get.textTheme.bodyText2,
//               confirm: SmallButton(
//                 iconSize: Size(80, 40),
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 function: () async {
//                   isChange = true;
//                   var isSuccess = await cartController.deleteItem(item);
//                   if (isSuccess) {
//                     count.value = 0;
//                   } else {
//                     count.value = tempCount;
//                   }
//                   isStartClick = true;
//                   tempCount = 0;
//                   textController!.text = count.value.toString();
//                   countWait.value = 0;
//                   Get.back();
//                 },
//                 text: 'Đồng ý',
//               ),
//               cancel: SmallButton(
//                   iconSize: Size(80, 40),
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   function: () {
//                     isStartClick = true;
//                     isChange = true;
//                     count.value = tempCount;
//                     tempCount = 0;
//                     countWait.value = 0;
//                     textController!.text = count.value.toString();
//                     Get.back();
//                   },
//                   text: 'Thoát'));
//           if (!isChange) {
//             count.value = tempCount;
//             textController!.text = count.value.toString();
//             tempCount = 0;
//             countWait.value = 0;
//             isStartClick = true;
//             textController!.text = count.value.toString();
//           }
//         } else {
//           if (decreaseClick != null) {
//             decreaseClick!();
//           }
//           var isSuccess = await cartController.deleteItem(item);

//           if (isSuccess) {
//             count.value = 0;
//             isStartClick = true;
//             tempCount = 0;
//             textController!.text = count.value.toString();
//             countWait.value = 0;
//           } else {
//             isStartClick = true;
//             count.value = tempCount;
//             tempCount = 0;
//             countWait.value = 0;
//             textController!.text = count.value.toString();
//           }
//         }
//       } else {
//         var countWaitTemp = countWait.value;
//         Future.delayed(delayTime, () async {
//           print(countWaitTemp);
//           print(countWait.value);
//           if (countWaitTemp == countWait.value && count.value != 0) {
//             var isSuccess = await cartController.updateItem(item, count.value);
//             if (isSuccess) {
//               // textController?.text = count.value.toString();
//             } else {
//               count.value = tempCount;
//               textController?.text = count.value.toString();
//               await Get.defaultDialog(
//                   title: 'Thông báo',
//                   content: Text('Cập nhập sản phẩm không thành công'));
//             }
//             tempCount = 0;
//             countWait.value = 0;
//             isStartClick = true;
//           } else {}
//         });
//       }
//     }
//   }
// }

// class MySlideTransition extends AnimatedWidget {
//   MySlideTransition({
//     Key? key,
//     required Animation<Offset> position,
//     this.transformHitTests = true,
//     this.child,
//   }) : super(key: key, listenable: position);

//   Animation<Offset> get position => listenable as Animation<Offset>;
//   final bool transformHitTests;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     var offset = position.value;
//     // When the exit animation is about to be performed
//     if (position.status == AnimationStatus.reverse) {
//       offset = Offset(-offset.dx, offset.dy);
//     }
//     return FractionalTranslation(
//       translation: offset,
//       transformHitTests: transformHitTests,
//       child: child,
//     );
//   }
// }

// enum CountItemType { CART, PRODUCT, VARIANT }
