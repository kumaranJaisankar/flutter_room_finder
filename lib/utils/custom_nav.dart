import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorIndexIcon extends StatelessWidget {
  const NavigatorIndexIcon({
    super.key,
    required this.currentIndex,
    required this.activeColor,
    required this.inActiveColor,
    required this.icon,
    required this.iconIndex,
  });

  final RxInt currentIndex;
  final Color activeColor;
  final Color inActiveColor;
  final IconData icon;
  final int iconIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              currentIndex.value = iconIndex;
            },
            icon: Icon(
              icon,
              size: 30.0,
              color:
                  currentIndex.value == iconIndex ? activeColor : inActiveColor,
              shadows: currentIndex.value == iconIndex
                  ? [
                      Shadow(
                          blurRadius: 10.0,
                          color: Colors.green,
                          offset: Offset(1, 2))
                    ]
                  : null,
            ),
          ),
          Visibility(
              visible: currentIndex.value == iconIndex, child: dartIcon())
        ],
      ),
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
