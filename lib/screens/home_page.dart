import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fire_flutter/constants/common_constant.dart';
import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/screens/AddRoomScreen/add_rooms.dart';
import 'package:fire_flutter/screens/detailViews/detail_view.dart';
import 'package:fire_flutter/searchAction/search_delegate.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<List<Rooms>> roomsList() => FirebaseFirestore.instance
          .collection('rooms')
          .snapshots()
          .map((snapshot) {
        log('messagsdsadasde');
        print(snapshot.docs.first.data());
        return snapshot.docs.map((doc) => Rooms.fromJson(doc.data())).toList();
      });

  Future<void> _handelRefresh() async {}

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              loggoutAlert(context);

              // AuthController.instance.logout();
            },
            icon: Icon(Icons.logout)),
        title: const Text('Room finder'),
        actions: <Widget>[
          InkWell(
            splashFactory: InkSplash.splashFactory,
            onTap: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
            child: const Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 10.0,
                ),
                Text("Search Room"),
                SizedBox(
                  width: 10.0,
                )
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     heroTag: UniqueKey(),
      //     isExtended: true,
      //     label: const Text('Add Rooms'),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(20.0)),
      //     onPressed: () {
      //       Get.to(() => AddRooms());
      //       // Navigator.push(context,
      //       //     MaterialPageRoute(builder: (context) => const AddRooms()));
      //     },
      //     icon: const Icon(Icons.add_business_sharp)),
      body: StreamBuilder(
          stream: roomsList(),
          builder: (context, snapshot) {
            print(snapshot.data);
            print(snapshot);
            print('object');
            print('kum');
            if (snapshot.hasError) {
              return Text("error occured ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                'empty',
                style: TextStyle(fontSize: 20.0),
              ));
            } else if (snapshot.hasData) {
              final datas = snapshot.data;
              return LiquidPullToRefresh(
                color: Colors.green,
                onRefresh: _handelRefresh,
                child: ListView(
                  children: datas!.map(buildRooms).toList(),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget buildRooms(Rooms room) => Slidable(
        key: Key(room.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {
          //   print('deleted');
          // }),
          children: const [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () async {
            final docs =
                FirebaseFirestore.instance.collection('rooms').doc(room.id);
            print(docs);
            await docs.delete();
            Toast.show('deleted ${room.roomName}',
                duration: Toast.lengthLong, gravity: Toast.bottom);
          }),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) {
                print('object');
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            )
          ],
        ),
        child: Column(children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeroPage(room: room)));
            },
            leading: SizedBox(
                width: 50.0,
                child: Hero(
                    tag: room.id,
                    child: Image.network(room.imgUrl, fit: BoxFit.cover))),
            title: Text(room.roomName),
            subtitle: Text('Rs:${room.price}/- per month'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Badge(
                    smallSize: 10.0,
                    backgroundColor:
                        room.isAvalibale ? Colors.green : Colors.red),
                addHorizontalSpacer(5.0),
                Text(room.isAvalibale ? 'avaliable' : 'unavaliable')
              ],
            ),
          ),
          addVerticalSpacer(10.0)
        ]),
      );
}
