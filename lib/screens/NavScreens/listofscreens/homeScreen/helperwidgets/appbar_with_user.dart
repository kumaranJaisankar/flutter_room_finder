import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/user_model.dart';
import '../../../../../utils/helperwidgets/helper_widgets.dart';

class HeaderUserDetail extends StatefulWidget {
  const HeaderUserDetail({
    super.key,
  });

  @override
  State<HeaderUserDetail> createState() => _HeaderUserDetailState();
}

class _HeaderUserDetailState extends State<HeaderUserDetail> {
  String? avatarUrl;
  String? userName;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? items = await prefs.getString('UserDetail');
      Users userMap = Users.fromJson(jsonDecode(items!));
      // print(items);
      // print(userMap);
      // print(userMap.id);
      setState(() {
        avatarUrl = userMap.avatraUrl;
        userName = userMap.name;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.5),
              backgroundImage: avatarUrl != null
                  ? NetworkImage(avatarUrl!)
                  : NetworkImage(
                      'https://res.cloudinary.com/dtbarluca/image/upload/v1692694826/user_1177568_mmmdi6.png'),
              radius: 25.0,
            ),
            addHorizontalSpacer(10.0),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Hello! ',
                  style: Theme.of(context).textTheme.subtitle1),
              TextSpan(
                  text: userName == null ? 'User' : userName,
                  style: Theme.of(context).textTheme.headline5)
            ])),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Badge(child: Icon(Icons.notifications_active_rounded)))
      ],
    );
  }
}
