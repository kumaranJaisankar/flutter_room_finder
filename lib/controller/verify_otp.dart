import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:fire_flutter/screens/userSignup/user_signup_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import '../screens/NavScreens/main_screen.dart';
import '../utils/helper_widgets.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  RxString phoneNo = ''.obs;
  RxString avatarNetworkUrl = ''.obs;
  RxString userId = ''.obs;
  var profileUrl =
      'https://res.cloudinary.com/dtbarluca/image/upload/v1692694826/user_1177568_mmmdi6.png';

  Future<void> verifyOtp(String otp, String phoneNumber) async {
    var isVerified = await AuthController.instance.verifyOtp(otp);

    isVerified
        ? isExistingUser(phoneNumber)
        : showErrorSnakbar(
            'Wrong OTP!', 'Plz enter correct OTP', SnackPosition.TOP);
  }

  void isExistingUser(String phoneNumber) {
    phoneNo.value = phoneNumber;
    avatarNetworkUrl.value = profileUrl;
    FirebaseFirestore.instance
        .collection('Users')
        .where('phoneNo', isEqualTo: phoneNumber)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        log('firebase empty');
        final docset = FirebaseFirestore.instance.collection('Users').doc();
        userId.value = docset.id;
        final userDetails = Users(
            id: docset.id,
            name: null,
            email: null,
            phoneNo: phoneNumber,
            avatraUrl: profileUrl);
        final toJsonFormat = userDetails.toJson();
        docset.set(toJsonFormat).then((value) {
          Get.off(() => UserSignup());
        }).catchError((e) => print(e));
      } else {
        log('gomalay');
        print(value.docs.first.data().runtimeType);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'UserDetail', jsonEncode(value.docs.first.data()));
        Get.offAll(() => DashboardScreen());
      }
    }).catchError(
            (error) => showErrorSnakbar('error', '$error', SnackPosition.TOP));
  }
}
