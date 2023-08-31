// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String? id;
  dynamic name;
  dynamic email;
  String? phoneNo;
  String? avatraUrl;

  Users({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.avatraUrl,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        avatraUrl: json["avatraUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "avatraUrl": avatraUrl,
      };
}
