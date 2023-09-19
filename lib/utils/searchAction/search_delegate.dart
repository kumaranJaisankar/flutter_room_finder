import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/screens/roomdetail/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/room_model.dart';
import '../helperwidgets/helper_widgets.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.close))
      ];
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    Container();
    return null;
  }

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    Stream<List<Rooms>> roomsList() => FirebaseFirestore.instance
        .collection('rooms')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Rooms.fromJson(doc.data())).toList());
    return StreamBuilder(
        stream: roomsList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error occured ${snapshot.error}");
          } else if (snapshot.hasData) {
            final datas = snapshot.data;
            List<Rooms> filterList = datas!.where((each) {
              return each.roomName.toLowerCase().contains(query.toLowerCase());
            }).toList();
            print(datas);
            if (filterList.length == 0) {
              return Center(
                child: Text('rooms not avaliable ☹'),
              );
            } else {
              return ListView(
                children: filterList.map((room) => buildRooms(room)).toList(),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildRooms(Rooms room) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: ListTile(
          tileColor: Colors.green.withOpacity(0.1),
          onTap: () {
            query = room.roomName;
            Get.to(() => RoomDetailScreen(room: room));
          },
          // leading: SizedBox(
          //     width: 50.0,
          //     child: Hero(
          //         tag: room.id,
          //         child: Image.network(room.imgUrl, fit: BoxFit.cover))),
          title: Text(
            room.roomName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // subtitle: Text('Rs:${room.price}/- per month'),
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
      );
}
