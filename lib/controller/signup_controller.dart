import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../models/user_model.dart';

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
    await docset.update(userDetails);

    log(userName);
    log(email);
    log(avatarUrl);
    log(userId);
  }
}
