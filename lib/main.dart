import 'dart:developer';

import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:fire_flutter/controller/signup_controller.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/notificationApi/firbase_notification.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:fire_flutter/theme/theme_constants.dart';
import 'package:flutter/services.dart';
// import 'package:fire_flutter/screens/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'firebase_options.dart';

import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '6LcgedMnAAAAAL2lStIZ7bmpc7ZewV39HeuKJ72F',
    appleProvider: AppleProvider.debug,
  );
  // firebase message
  await FirebaseNotification().initNotification();
  Get.put(SignUpController());
  Get.put(OtpController());
  await SystemChrome.setPreferredOrientations([
    //this will make application in same orientaion
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  // EasyLoadingStyle.custom;
  // we can customize this easy loading in main instance by using CTRL + click on EasyLoading
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 15.0
    ..progressColor = Colors.green
    ..backgroundColor = Get.isDarkMode ? Colors.black : Colors.white
    ..indicatorColor = Colors.green
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.custom;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Room Finder',

      // darkTheme: ThemeData(
      //   colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
      // ),
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      // home: const MyHomePage(),
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
