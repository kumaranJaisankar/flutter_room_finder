import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorIndexIcon extends StatelessWidget {
  const NavigatorIndexIcon(
      {super.key,
      required this.currentIndex,
      required this.activeColor,
      required this.inActiveColor,
      required this.icon,
      required this.iconIndex,
      required this.onPressNavIndex});

  final int currentIndex;
  final Color activeColor;
  final Color inActiveColor;
  final IconData icon;
  final int iconIndex;
  final VoidCallback onPressNavIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressNavIndex,
          icon: Icon(
            icon,
            size: 30.0,
            color: currentIndex == iconIndex ? activeColor : inActiveColor,
            shadows: currentIndex == iconIndex
                ? [
                    Shadow(
                        blurRadius: 10.0,
                        color: Colors.green,
                        offset: Offset(1, 2))
                  ]
                : null,
          ),
        ),
        Visibility(visible: currentIndex == iconIndex, child: dartIcon())
      ],
    );
  }
}

Icon dartIcon() {
  return Icon(
    Icons.circle,
    size: 10.0,
    color: Colors.green,
    grade: 10.0,
    shadows: [
      Shadow(blurRadius: 10.0, color: Colors.green, offset: Offset(1, 2))
    ],
  );
}
