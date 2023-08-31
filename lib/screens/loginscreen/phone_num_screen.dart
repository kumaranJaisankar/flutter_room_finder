import 'dart:developer';

import 'package:fire_flutter/constants/color_contatnts.dart';
import 'package:fire_flutter/screens/loginscreen/otp_screen.dart';
import 'package:fire_flutter/theme/theme_constants.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import '../../controller/signup_controller.dart';
// import '../../controller/verify_otp.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumScreen extends StatefulWidget {
  const PhoneNumScreen({super.key});

  @override
  State<PhoneNumScreen> createState() => _PhoneNumScreenState();
}

class _PhoneNumScreenState extends State<PhoneNumScreen> {
  final TextEditingController phoneNumber = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: '');

  @override
  void dispose() {
    // TODO: implement dispose
    log('tig');
    phoneNumber.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneNumber.text.length));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.elliptical(440.0, 300.0),
                        bottomEnd: Radius.elliptical(440.0, 300.0),
                        bottomStart: Radius.elliptical(140.0, 300.0),
                        topStart: Radius.elliptical(40.0, 100.0),
                      )),
                  child: Image.asset('assets/images/Fingerprint-cuate.png'),
                  width: 250.0,
                ),
                addVerticalSpacer(15),
                Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                addVerticalSpacer(10),
                Text(
                  "Add your phone number. We'll send you verification code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
                addVerticalSpacer(10.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      phoneNumber.text = value;
                    });
                  },
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.green,
                  controller: phoneNumber,
                  decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: secondaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 500.0),
                              context: context,
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            );
                          },
                          child: Text(
                            '${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      suffixIcon: phoneNumber.text.length > 9
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : null),
                ),
                addVerticalSpacer(20.0),
                SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      String exactPhoneNum =
                          '+${selectedCountry.phoneCode}${phoneNumber.text.trim()}';
                      SignUpController.instance
                          .phoneAuthentication(exactPhoneNum);
                      phoneNumber.text = '';
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)))),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.changeTheme(darkTheme);
                //       EasyLoading.show();
                //       showSnakbar('title', Get.isDarkMode.toString(),
                //           SnackPosition.BOTTOM);
                //     },
                //     child: Text('enter phone number')),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.changeThemeMode(ThemeMode.light);
                //       EasyLoading.dismiss();
                //     },
                //     child: Text('verify otp')),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
