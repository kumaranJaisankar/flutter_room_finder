import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Notifi> notifiFromJson(String str) =>
    List<Notifi>.from(json.decode(str).map((x) => Notifi.fromJson(x)));

String notifiToJson(List<Notifi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifi {
  Timestamp msgReciveTime;
  String? payload;
  bool isOpend;
  String id;
  String body;
  String title;

  Notifi({
    required this.msgReciveTime,
    required this.payload,
    required this.isOpend,
    required this.id,
    required this.body,
    required this.title,
  });

  factory Notifi.fromJson(Map<String, dynamic> json) => Notifi(
        msgReciveTime: json["msgReciveTime"],
        payload: json["payload"],
        isOpend: json["isOpend"],
        id: json["id"],
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "msgReciveTime": msgReciveTime,
        "payload": payload,
        "isOpend": isOpend,
        "id": id,
        "body": body,
        "title": title,
      };
}
