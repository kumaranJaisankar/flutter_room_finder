import 'dart:developer';

import 'package:fire_flutter/constants/color_contatnts.dart';
import 'package:fire_flutter/screens/AddRoomScreen/add_rooms.dart';
import 'package:fire_flutter/screens/NavScreens/listofscreens/NotificationScreen/notification_screen.dart';
import 'package:fire_flutter/screens/NavScreens/listofscreens/homeScreen/home_screen.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:fire_flutter/screens/userSignup/user_signup_screen.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_nav.dart';
import 'listofscreens/profileScreen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List Pages = [
      HomeScreen(),
      MyHomePage(),
      NotificationScreen(),
      UserProfileDetails()
    ];
    Color activeColor = Colors.green;
    Color inActiveColor = Colors.green.shade100;
    log(Get.isDarkMode.toString());
    return Scaffold(
        drawer: currentIndex == 0 ? Drawer() : null,
        extendBody: true,
        body: Center(
          child: Pages.elementAt(currentIndex),
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
                    onPressNavIndex: () {
                      print('object');
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    currentIndex: currentIndex,
                    activeColor: activeColor,
                    inActiveColor: inActiveColor,
                    iconIndex: 0,
                    icon: Icons.home_rounded,
                  ),
                  NavigatorIndexIcon(
                      onPressNavIndex: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      currentIndex: currentIndex,
                      activeColor: activeColor,
                      inActiveColor: inActiveColor,
                      icon: Icons.bookmark_rounded,
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
                      onPressNavIndex: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      currentIndex: currentIndex,
                      activeColor: activeColor,
                      inActiveColor: inActiveColor,
                      icon: Icons.notifications,
                      iconIndex: 2),
                  NavigatorIndexIcon(
                      onPressNavIndex: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      },
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
