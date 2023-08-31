import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/controller/signup_controller.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/dashboard/dashboard.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import '../../utils/helper_widgets.dart';
import 'helperwidgetforsignup/signup_helper.dart';
import 'package:path/path.dart' as p;
import 'package:image_cropper/image_cropper.dart';

class Userform extends StatefulWidget {
  Userform({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<Userform> createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  final contrlr = Get.put(OtpController());

  final signupController = Get.put(SignUpController());

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final _globalKey = GlobalKey<FormState>();

    return Form(
      key: _globalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50.0))),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 170.0,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: OutlinedButton.icon(
                                label: Text('camera'),
                                onPressed: () async {
                                  final camPic = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  imageGetter(camPic);
                                },
                                icon: Icon(Icons.photo_camera)),
                          ),
                          addHorizontalSpacer(20.0),
                          Container(
                            child: OutlinedButton.icon(
                                label: Text('Gallery'),
                                onPressed: () async {
                                  final finalImage = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  imageGetter(finalImage);
                                },
                                icon: Icon(Icons.image)),
                          )
                          // TextButton(
                          //   child: const Text('close'),
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                        ],
                      )),
                    );
                  });
            },
            radius: 00.0,
            child: Stack(children: [
              selectedImage != null
                  ? CircleAvatar(
                      radius: 80.0,
                      backgroundImage: FileImage(selectedImage!),
                    )
                  : Obx(
                      () => CircleAvatar(
                        radius: 80.0,
                        backgroundImage:
                            NetworkImage(contrlr.avatarNetworkUrl.value),
                      ),
                    ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(Icons.add_a_photo),
                  ))
            ]),
          ),
          addVerticalSpacer(30.0),
          customTextField('Username', 'eg. Rahul', Icons.person,
              signupController.username.text, true, signupController.username),
          addVerticalSpacer(20.0),
          customTextField('Email', 'Enter Email', Icons.email,
              signupController.email.text, true, signupController.email),
          addVerticalSpacer(20.0),
          Obx(
            () => customTextField('Phone No', 'Enter phone Number', Icons.phone,
                contrlr.phoneNo.value, false, signupController.phno),
          ),
          addVerticalSpacer(25.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: ElevatedButton(
                onPressed: () async {
                  // String userId = contrlr.userId.value;
                  // String userName = signupController.username.text.trim();
                  // String email = signupController.email.text.trim();
                  // String avatarUrl = contrlr.avatarNetworkUrl.value;
                  EasyLoading.show();
                  if (_globalKey.currentState!.validate()) {
                    String userId = contrlr.userId.value;
                    String userName = signupController.username.text.trim();
                    String email = signupController.email.text.trim();
                    String avatarUrl = contrlr.avatarNetworkUrl.value;
                    String phNum = contrlr.phoneNo.value;

                    if (selectedImage != null) {
                      final path =
                          '${DateTime.now().toIso8601String()}+ ${p.basename(selectedImage!.path)}';
                      final imageInstance = FirebaseStorage.instance
                          .ref()
                          .child('profilePics')
                          .child(path);
                      final result = await imageInstance
                          .putFile(File(selectedImage!.path));
                      avatarUrl = await result.ref.getDownloadURL();
                      SignUpController.instance.createUserDetails(
                          userName, email, avatarUrl, userId, phNum);
                      EasyLoading.dismiss();
                      Get.offAll(() => DashboardScreen());
                    } else {
                      SignUpController.instance.createUserDetails(
                          userName, email, avatarUrl, userId, phNum);
                      EasyLoading.dismiss();
                      Get.offAll(() => DashboardScreen());
                    }
                    signupController.username.text = '';
                    signupController.email.text = '';
                  } else {
                    // contrlr.userId.value = 'k1k2k3k4';
                    // contrlr.phoneNo.value = '9092296765';
                    // contrlr.avatarNetworkUrl.value =
                    //     'https://res.cloudinary.com/dtbarluca/image/upload/v1692694826/user_1177568_mmmdi6.png';
                    // log(signupController.username.text);
                    // log(contrlr.avatarNetworkUrl.value);
                    // log(contrlr.userId.value);
                  }
                },
                child: Text('Continue'),
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.resolveWith((states) =>
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150.0))))),
          ),
        ],
      ),
    );
  }

  Future imageGetter(XFile? finalImage) async {
    if (finalImage == null) return;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: finalImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Avatar',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Avatar',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile == null) return;
    setState(() {
      selectedImage = File(croppedFile.path);
      Get.back();
    });
  }
}
