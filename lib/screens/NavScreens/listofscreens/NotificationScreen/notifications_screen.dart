import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/constants/json_notifi.dart';
import 'package:fire_flutter/constants/shared_prf_data.dart';
import 'package:fire_flutter/models/notification_model.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/roomdetail/detail_view.dart';
import 'package:fire_flutter/utils/helperwidgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String userId = 'fdg';

  @override
  void initState() {
    super.initState();
    initiate();
  }

  void initiate() async {
    Users userDetail = await userDataFromStorage();
    setState(() {
      userId = userDetail.id!;
    });
  }

  Stream<List<Notifi>> notifiList() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('notification')
        .orderBy('msgReciveTime', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Notifi.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: notifiList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error occured ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              final datas = snapshot.data;
              return ListView(
                physics: BouncingScrollPhysics(),
                children: datas!.map(notifiListTile).toList(),
              );
            }
          },
        ));
  }

  Widget notifiListTile(Notifi e) {
    {
      DateTime date = e.msgReciveTime.toDate();
      final msgRes = Jiffy.parseFromDateTime(date).fromNow();

      return ListTile(
        onTap: () {
          final _doc = FirebaseFirestore.instance;
          final _updateNoti = _doc
              .collection('Users')
              .doc(userId)
              .collection('notification')
              .doc(e.id);
          var _data = {"isOpend": true};
          _updateNoti.update(_data);
          String? payld = e.payload;
          var datass = jsonDecode(payld!);
          Map<String, dynamic> fromjson = jsonForDetailpage(datass);
          Rooms room = Rooms.geoPointJson(fromjson);
          Get.to(() => RoomDetailScreen(room: room));
        },
        splashColor: Colors.black12,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !e.isOpend,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 5.0,
                ),
              ),
            ),
            Image.network(
                "https://firebasestorage.googleapis.com/v0/b/my-portfolio-fe1ff.appspot.com/o/1bhk-wadala.jpg?alt=media&token=1031fbe9-ff49-4c90-86f7-3e1a1f3ca932",
                fit: BoxFit.cover),
          ],
        ),
        tileColor: !e.isOpend ? Colors.green[100] : null,
        title: Text(e.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.body),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  msgRes,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
        horizontalTitleGap: 10,
      );
    }
  }
}
