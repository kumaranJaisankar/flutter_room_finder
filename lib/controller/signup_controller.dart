import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final username = TextEditingController();
  final email = TextEditingController();
  final phno = TextEditingController();

  void phoneAuthentication(String PhoneNo) {
    AuthController.instance.phoneAuth(PhoneNo);
  }

  Future<void> createUserDetails(String userName, String email,
      String avatarUrl, String userId, String phNum) async {
    final docset = FirebaseFirestore.instance.collection('Users').doc(userId);

    final userDetails = {
      'name': userName,
      'email': email,
      'avatraUrl': avatarUrl
    };
    // ignore: unused_local_variable
    var newVariable = await docset.update(userDetails);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map<String, dynamic> detailObj = {
        'id': userId,
        'name': userName,
        'email': email,
        'phoneNo': phNum,
        'avatraUrl': avatarUrl
      };

      await prefs.setString('UserDetail', jsonEncode(detailObj));
    } catch (e) {
      print(e);
    }

    log(userName);
    log(email);
    log(phNum);
    log(avatarUrl);
    log(userId);
  }
}
