// To parse this JSON data, do
//
//     final rooms = roomsFromJson(jsonString);

import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Rooms> roomsFromJson(String str) =>
    List<Rooms>.from(json.decode(str).map((x) => Rooms.fromJson(x)));

String roomsToJson(List<Rooms> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rooms {
  String id;
  String roomName;
  int price;
  String location;
  bool isAvalibale;
  String imgUrl;
  GeoPoint geoLocation;

  Rooms(
      {this.id = '',
      required this.roomName,
      required this.price,
      required this.location,
      required this.isAvalibale,
      required this.imgUrl,
      required this.geoLocation});

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
        id: json["id"],
        roomName: json["roomName"],
        price: json["price"],
        location: json["location"],
        isAvalibale: json["isAvalibale"],
        imgUrl: json["imgUrl"],
        geoLocation: json["geoLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roomName": roomName,
        "price": price,
        "location": location,
        "isAvalibale": isAvalibale,
        "imgUrl": imgUrl,
        "geoLocation": geoLocation
      };
}
