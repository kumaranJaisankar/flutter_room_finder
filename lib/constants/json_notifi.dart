import 'dart:convert';

Map<String, dynamic> jsonForDetailpage(Map<String, dynamic> payLoad) {
  Map<String, dynamic> jsn = {
    "imgUrl": payLoad["imgUrl"],
    "isAvalibale": jsonDecode(payLoad["isAvalibale"]),
    "geoLocation": {
      "latitude": jsonDecode(payLoad["geoLocation"])["latitude"],
      "longitude": jsonDecode(payLoad["geoLocation"])["longitude"]
    },
    "price": jsonDecode(payLoad["price"]),
    "rating": jsonDecode(payLoad["rating"]) + 0.0,
    "location": payLoad["location"],
    "id": payLoad["id"],
    "roomName": payLoad["roomName"]
  };
  return jsn;
}
