import 'dart:convert';

import 'package:fire_flutter/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Users> userDataFromStorage() async {
  final prf = await SharedPreferences.getInstance();
  final data = prf.getString('UserDetail');
  Map<String, dynamic> decodedData = jsonDecode(data!);
  Users userDetail = Users.fromJson(decodedData);

  return userDetail;
}

class LetGetData extends GetxController {
  static LetGetData get instance => Get.find();
  String usId = '';
  @override
  void onReady() {
    usId = 'kuma';
  }
}
