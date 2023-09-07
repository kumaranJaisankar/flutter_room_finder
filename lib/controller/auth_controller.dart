import 'dart:developer';

import 'package:fire_flutter/screens/NavScreens/main_screen.dart';
import 'package:fire_flutter/screens/loginscreen/intro_screen.dart';
import 'package:fire_flutter/screens/loginscreen/otp_screen.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    user == null
        ? Get.offAll(() => const IntroScreen())
        : Get.offAll(() => const DashboardScreen());
    // user != null
    //     ? Get.offAll(() => UserSignup())
    //     : Get.offAll(() => const IntroScreen());
  }

  Future<void> logout() async => await _auth.signOut();

  Future<void> phoneAuth(String phone) async {
    try {
      EasyLoading.show();
      // credentials = null;
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            log('Completed');
            // credentials = credential;
            await _auth.signInWithCredential(credential);
            EasyLoading.dismiss();
          },
          // forceResendingToken: resendTokenId,
          verificationFailed: (FirebaseAuthException e) {
            log('failed');
            if (e.code == 'invalid-phone-number') {
              showErrorSnakbar(
                'Error',
                'The provided phone number is not valid ',
                SnackPosition.BOTTOM,
              );
            } else {
              showErrorSnakbar(
                  "Error", 'Something went wrong 😥', SnackPosition.TOP);
            }
            EasyLoading.dismiss();
          },
          codeSent: (String verificationId, int? resendToken) async {
            this.verificationId.value = verificationId;
            log('code sent');
            Get.to(() => OtpVerificationScreen(phoneNum: phone));

            EasyLoading.dismiss();
            // verId = verificationId;
            // resendTokenId = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      showErrorSnakbar('error', e.toString(), SnackPosition.BOTTOM);
    }
  }

  Future<bool> verifyOtp(String otp) async {
    log('triggred');
    bool isVerified;
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId.value, smsCode: otp));
      isVerified = true;
      log(credentials.user.toString());
    } catch (e) {
      isVerified = false;
      log(e.toString());
    }
    return isVerified;
    // return credentials.user != null ? true : false;
  }
}
