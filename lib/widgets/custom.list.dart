import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_admin/utils/helpes/utilities.dart';

// ignore: must_be_immutable
class CustomList extends StatelessWidget {
  final int mainAxisCount;
  final Axis scrollDirection;
  final ScrollPhysics? scrollPhysics;
  final Function(int index)? onClickItem;
  final Widget Function(int index)? customWidget;
  final List<String?>? images;
  final int? itemCount;
  final double? widthItem;
  final double? heightItem;
  final double? crossSpace;
  final double? mainSpace;
  final EdgeInsets padding;
  final double borderRadius;
  final bool? shrinkWrap;
  final Color? backgroundColor;
  final ScrollController? scrollController;
  final BoxShadow? boxShadow;
  TypeCustomList? type;

  CustomList({
    Key? key,
    this.mainAxisCount = 1,
    this.shrinkWrap,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.scrollPhysics,
    this.onClickItem,
    this.customWidget,
    this.images,
    this.itemCount,
    this.widthItem,
    this.heightItem,
    this.crossSpace,
    this.mainSpace,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = 0,
    this.boxShadow,
    this.backgroundColor,
  }) : assert(images != null || (itemCount != null && customWidget != null),
            'Must have images to list image or itemCount if have customWidget') {
    if (customWidget != null && itemCount != null) {
      type = TypeCustomList.CUSTOM;
    } else {
      type = TypeCustomList.IMAGE;
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemCountReal =
        type == TypeCustomList.IMAGE ? images!.length : itemCount;
    var itemCountTemp = itemCountReal;
    if (mainAxisCount > 0) {
      itemCountTemp = (itemCountTemp! / mainAxisCount).ceil();
    }
    if (itemCountTemp == 0) return Container();

    return LayoutBuilder(builder: (context, snapshot) {
      var width = snapshot.constrainWidth() / (mainAxisCount) -
          padding.left -
          padding.right;
      var height = snapshot.constrainHeight() / (mainAxisCount) -
          padding.top -
          padding.bottom;
      return ListView.builder(
          shrinkWrap: shrinkWrap ?? true,
          scrollDirection: scrollDirection,
          physics: scrollPhysics,
          controller: scrollController,
          itemCount: itemCountTemp,
          padding: EdgeInsets.all(0),
          itemBuilder: (contex, index) {
            if (scrollDirection == Axis.vertical) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _getChild(
                      index, itemCountReal, itemCountTemp, width, height),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _getChild(
                      index, itemCountReal, itemCountTemp, width, height),
                ),
              );
            }
          });
    });
  }

  List<Widget> _getChild(int index, int? itemCountReal, int? itemCountTemp,
      double width, double height) {
    var tempMainAxisCount = mainAxisCount;
    if (mainAxisCount < 0) {
      tempMainAxisCount = 1;
    }
    var count = <int>[];
    for (var i = 0; i < tempMainAxisCount; i++) {
      count.add(index * tempMainAxisCount + i);
    }
    return count
        .map(
          (indexItem) => GestureDetector(
            onTap: () {
              if (onClickItem != null) {
                onClickItem!(indexItem);
              }
            },
            child: indexItem < itemCountReal!
                ? Container(
                    margin: _getPadding(index, count.first, count.last,
                        indexItem, itemCountTemp!, tempMainAxisCount),
                    height: scrollDirection == Axis.vertical
                        ? heightItem
                        : (heightItem ?? height),
                    width: scrollDirection == Axis.vertical
                        ? (widthItem ?? width)
                        : widthItem,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.white,
                      boxShadow: boxShadow != null ? [boxShadow!] : [],
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: type == TypeCustomList.IMAGE
                          ? Utilities.getImageNetwork(images![indexItem],
                              fit: BoxFit.contain)
                          : customWidget!(indexItem),
                    ))
                : Container(),
          ),
        )
        .toList();
  }

  EdgeInsets _getPadding(int indexGroup, int firstInGroup, int lastInGroup,
      int indexItem, int itemCountTemp, int mainAxisCount) {
    if (itemCountTemp - 1 == 0) {
      if (indexItem == 0) {
        return padding;
      }
      return scrollDirection == Axis.horizontal
          ? EdgeInsets.only(
              top: indexItem == 0 ? padding.top : 0,
              bottom: indexItem == mainAxisCount - 1
                  ? (crossSpace ?? 0)
                  : padding.bottom,
              right: padding.right,
              left: padding.left)
          : EdgeInsets.only(
              left: indexItem == 0 ? padding.left : 0,
              right: indexItem == mainAxisCount - 1
                  ? (crossSpace ?? 0)
                  : padding.right,
              top: padding.top,
              bottom: padding.bottom);
    }
    if (firstInGroup == indexItem && indexGroup != itemCountTemp - 1) {
      if (mainAxisCount == 1) {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                top: indexGroup == 0 ? padding.top : 0,
                bottom: mainSpace ?? 0,
                right: padding.right,
                left: padding.left)
            : EdgeInsets.only(
                left: indexGroup == 0 ? padding.left : 0,
                right: mainSpace ?? 0,
                top: padding.top,
                bottom: padding.bottom);
      } else {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                top: indexGroup == 0 ? padding.top : 0,
                bottom: mainSpace ?? 0,
                right: crossSpace ?? 0,
                left: padding.left)
            : EdgeInsets.only(
                left: indexGroup == 0 ? padding.left : 0,
                right: mainSpace ?? 0,
                top: padding.top,
                bottom: crossSpace ?? 0);
      }
    }
    if (firstInGroup == indexItem && indexGroup == itemCountTemp - 1) {
      if (mainAxisCount == 1) {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                bottom: padding.bottom,
                right: padding.right,
                left: padding.left)
            : EdgeInsets.only(
                right: padding.right, top: padding.top, bottom: padding.bottom);
      } else {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                bottom: padding.bottom,
                left: padding.left,
                right: crossSpace ?? 0)
            : EdgeInsets.only(
                top: padding.top,
                right: padding.right,
                bottom: crossSpace ?? 0);
      }
    }
    if (lastInGroup == indexItem && indexGroup != itemCountTemp - 1) {
      if (mainAxisCount == 1) {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                top: indexGroup == 0 ? padding.top : 0,
                bottom: mainSpace ?? 0,
                right: padding.right,
                left: padding.left)
            : EdgeInsets.only(
                left: indexGroup == 0 ? padding.left : 0,
                right: mainSpace ?? 0,
                top: padding.top,
                bottom: padding.bottom);
      } else {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                top: indexGroup == 0 ? padding.top : 0,
                bottom: crossSpace ?? 0,
                right: padding.right)
            : EdgeInsets.only(
                left: indexGroup == 0 ? padding.left : 0,
                right: mainSpace ?? 0,
                bottom: padding.bottom);
      }
    }
    if (lastInGroup == indexItem && indexGroup == itemCountTemp - 1) {
      if (mainAxisCount == 1) {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(
                left: padding.left,
                right: padding.right,
                bottom: padding.bottom)
            : EdgeInsets.only(
                bottom: padding.bottom, right: padding.right, top: padding.top);
      } else {
        return scrollDirection == Axis.vertical
            ? EdgeInsets.only(right: padding.right, bottom: padding.bottom)
            : EdgeInsets.only(right: padding.right, bottom: padding.bottom);
      }
    }
    if (indexGroup == 0) {
      return scrollDirection == Axis.vertical
          ? EdgeInsets.only(
              right: crossSpace ?? 0, bottom: mainSpace ?? 0, top: padding.top)
          : EdgeInsets.only(
              bottom: crossSpace ?? 0,
              right: mainSpace ?? 0,
              left: padding.left);
    } else if (indexGroup == itemCountTemp - 1) {
      return scrollDirection == Axis.vertical
          ? EdgeInsets.only(bottom: padding.bottom, right: crossSpace ?? 0)
          : EdgeInsets.only(
              right: padding.right,
              bottom: crossSpace ?? 0,
            );
    } else {
      return scrollDirection == Axis.vertical
          ? EdgeInsets.only(right: crossSpace ?? 0, bottom: mainSpace ?? 0)
          : EdgeInsets.only(bottom: crossSpace ?? 0, right: mainSpace ?? 0);
    }
  }
}

enum TypeCustomList { IMAGE, CUSTOM }
