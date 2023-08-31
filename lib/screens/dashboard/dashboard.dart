import 'dart:developer';

import 'package:fire_flutter/constants/color_contatnts.dart';
import 'package:fire_flutter/screens/AddRoomScreen/add_rooms.dart';
import 'package:fire_flutter/screens/dashboard/listofscreens/home_screen.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:fire_flutter/screens/userSignup/user_signup_screen.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_nav.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentIndex = 0.obs;

    List Pages = [HomeScreen(), Text("SEARCH"), MyHomePage(), UserSignup()];
    Color activeColor = Colors.green;
    Color inActiveColor = Colors.green.shade100;
    log(Get.isDarkMode.toString());
    return Scaffold(
        drawer: currentIndex.value == 0 ? Drawer() : null,
        extendBody: true,
        body: Obx(
          () => Center(
            child: Pages.elementAt(currentIndex.value),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: BottomAppBar(
              surfaceTintColor: Colors.green,
              elevation: 100.0,
              height: 70.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigatorIndexIcon(
                    currentIndex: currentIndex,
                    activeColor: activeColor,
                    inActiveColor: inActiveColor,
                    iconIndex: 0,
                    icon: Icons.home_rounded,
                  ),
                  NavigatorIndexIcon(
                      currentIndex: currentIndex,
                      activeColor: activeColor,
                      inActiveColor: inActiveColor,
                      icon: Icons.search_rounded,
                      iconIndex: 1),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100.0)),
                    child: IconButton(
                        onPressed: () => Get.to(() => AddRooms()),
                        icon: Icon(Icons.add,
                            color: Colors.white, weight: 500.0)),
                  ),
                  NavigatorIndexIcon(
                      currentIndex: currentIndex,
                      activeColor: activeColor,
                      inActiveColor: inActiveColor,
                      icon: Icons.bookmark_rounded,
                      iconIndex: 2),
                  NavigatorIndexIcon(
                      currentIndex: currentIndex,
                      activeColor: activeColor,
                      inActiveColor: inActiveColor,
                      icon: Icons.person_rounded,
                      iconIndex: 3),
                ],
              ),
            ),
          ),
        ));
  }
}
