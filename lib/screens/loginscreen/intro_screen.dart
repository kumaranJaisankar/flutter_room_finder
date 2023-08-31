import 'package:fire_flutter/controller/signup_controller.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/screens/loginscreen/phone_num_screen.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.elliptical(440.0, 300.0),
                      bottomEnd: Radius.elliptical(440.0, 300.0),
                      bottomStart: Radius.elliptical(140.0, 300.0),
                      topStart: Radius.elliptical(140.0, 300.0),
                    )),
                child: Image.asset('assets/images/Jealous-amico.png'),
                width: 350.0,
              ),
              addVerticalSpacer(10.0),
              Text(
                'Welcome to Room Finder ',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              addVerticalSpacer(10.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => PhoneNumScreen());
                  },
                  child: Text(
                    'Get started',
                  ),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.resolveWith((states) =>
                          TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150.0)))),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       controller.phoneNo.value = '9092296765';
              //     },
              //     child: Text('update GetX')),
              // ElevatedButton(
              //     onPressed: () {
              //       controller.avatarNetworkUrl.value = 'www.kumk.com';
              //     },
              //     child: Text('retive from GetX')),
              // Obx(() => Text(controller.phoneNo.value)),
              // Obx(() => Text(controller.avatarNetworkUrl.value)),
            ],
          ),
        ),
      ),
    );
  }
}
