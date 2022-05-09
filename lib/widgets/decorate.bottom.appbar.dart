import 'package:flutter/material.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar({required this.tabBar, required this.decoration});

  final Widget tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => Size(0, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
