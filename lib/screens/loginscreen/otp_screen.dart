import 'package:fire_flutter/constants/color_contatnts.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/screens/loginscreen/phone_num_screen.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNum;
  OtpVerificationScreen({super.key, required this.phoneNum});
  final otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Column(children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: IconButton(
              //       onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
              // ),
              addVerticalSpacer(20.0),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.elliptical(440.0, 300.0),
                      bottomEnd: Radius.elliptical(440.0, 300.0),
                      bottomStart: Radius.elliptical(140.0, 300.0),
                      topStart: Radius.elliptical(140.0, 300.0),
                    )),
                child: Image.asset('assets/images/Enter OTP-amico.png'),
                width: 160.0,
              ),
              addVerticalSpacer(15),
              Text(
                'Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              addVerticalSpacer(10),
              Text(
                "Enter the OTP sent to your phone number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: secondaryColor),
                textAlign: TextAlign.center,
              ),
              addVerticalSpacer(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addHorizontalSpacer(20.0),
                  Text(
                    phoneNum,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(() => PhoneNumScreen());
                      },
                      icon: Icon(
                        Icons.mode_edit_outlined,
                        color: Colors.green,
                      ))
                ],
              ),
              addVerticalSpacer(10.0),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Pinput(
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  length: 6,
                  onCompleted: (value) =>
                      // otpController.verifyOtp(value.toString().trim(), phoneNum)
                      OtpController.instance
                          .verifyOtp(value.toString().trim(), phoneNum),
                  defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                ),
              ),
              addVerticalSpacer(10.0),
              Text("Didn't recive any code?"),
              addVerticalSpacer(10.0),
              Text(
                'Resend OTP',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
