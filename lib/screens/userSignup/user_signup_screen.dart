import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/constants/color_contatnts.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/userSignup/user_form.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:get/get.dart';

class UserSignup extends StatelessWidget {
  const UserSignup({super.key, this.phoneNo, this.avatarUrl});

  final String? phoneNo;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Userform(
                  phoneNumber: '+919092296765',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class UserSignup extends StatelessWidget {
//   UserSignup({super.key});

//   CollectionReference userInstance =
//       FirebaseFirestore.instance.collection('Users');

//   Future<void> addUser() async {
//     // Call the user's CollectionReference to add a new user
//     FirebaseFirestore.instance
//         .collection('Users')
//         .where('phoneNo', isEqualTo: "+919092296765")
//         .get()
//         .then((value) {
//       if (value.docs.isEmpty) {
//         log('its empty');
//       } else {
//         log(value.docs.first.data()['isUserCreated'].toString());
//         log('its contain');
//       }
//     });
//   }

//   Future<void> userSignupHere() async {
//     final docset = userInstance.doc();
//     final userDetails = Users(
//         id: docset.id,
//         name: 'kumaran',
//         email: null,
//         phoneNo: '+919092296765',
//         avatraUrl:
//             'https://res.cloudinary.com/dtbarluca/image/upload/v1692694826/user_1177568_mmmdi6.png');
//     final toJsonFormat = userDetails.toJson();
//     return docset
//         .set(toJsonFormat)
//         .then((value) => log('user added'))
//         .catchError((e) => log('${e}'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextButton(
//             onPressed: () {
//               log('hi');
//               userSignupHere();
//             },
//             child: Text('get datas'),
//           ),
//           addVerticalSpacer(10.0),
//           OutlinedButton(
//               onPressed: () {
//                 addUser();
//               },
//               child: Text('update data'))
//         ],
//       )),
//     );
//   }
// }
