import 'dart:convert';
import 'dart:io';

import 'package:fire_flutter/constants/common_constant.dart';
import 'package:fire_flutter/controller/signup_controller.dart';
import 'package:fire_flutter/controller/verify_otp.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/NavScreens/main_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/custom_widgets.dart';
import '../../../../../utils/helper_widgets.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final contrlr = Get.put(OtpController());

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNum = TextEditingController();
  String? id = '';
  String? name = '';
  String? email = '';
  String? phoneNumber = '';
  String profilePicUrl =
      'https://res.cloudinary.com/dtbarluca/image/upload/v1692694826/user_1177568_mmmdi6.png';

  final signupController = Get.put(SignUpController());

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    getFromStorage();
  }

  Future<void> getFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDetail = prefs.getString('UserDetail');
    Users usermaping = Users.fromJson(jsonDecode(userDetail!));

    setState(() {
      id = usermaping.id;
      name = usermaping.name;
      email = usermaping.email;
      phoneNumber = usermaping.phoneNo;
      profilePicUrl = usermaping.avatraUrl!;
    });
  }

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
                  : CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(profilePicUrl!),
                    ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.white,
                    ),
                  ))
            ]),
          ),
          addVerticalSpacer(30.0),
          customTextField(
              'Username', 'eg. Rahul', Icons.person, name!, true, _name),
          addVerticalSpacer(20.0),
          customTextField(
              'Email', 'Enter Email', Icons.email, email!, true, _email),
          addVerticalSpacer(20.0),
          customTextField('Phone No', 'Enter phone Number', Icons.phone,
              phoneNumber!, false, _phoneNum),
          addVerticalSpacer(25.0),
          ElevatedButton.icon(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                // String userId = contrlr.userId.value;
                // String userName = signupController.username.text.trim();
                // String email = signupController.email.text.trim();
                // String avatarUrl = contrlr.avatarNetworkUrl.value;
                EasyLoading.show();
                if (_globalKey.currentState!.validate()) {
                  String userId = id!;
                  String userName = _name.text.trim();
                  String email = _email.text.trim();
                  String avatarUrl = profilePicUrl;
                  String phNum = contrlr.phoneNo.value;

                  if (selectedImage != null) {
                    final path =
                        '${DateTime.now().toIso8601String()}${p.basename(selectedImage!.path)}';
                    final imageInstance = FirebaseStorage.instance
                        .ref()
                        .child('profilePics')
                        .child(path);
                    final result =
                        await imageInstance.putFile(File(selectedImage!.path));
                    avatarUrl = await result.ref.getDownloadURL();
                    SignUpController.instance.createUserDetails(
                        userName, email, avatarUrl, userId, phNum);
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess('Successfully updated');
                  } else {
                    SignUpController.instance.createUserDetails(
                        userName, email, avatarUrl, userId, phNum);
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess('Successfully updated');
                  }
                }
              },
              icon: Icon(Icons.save_alt),
              label: Text('Save'),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith((states) =>
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150.0))))),
          ElevatedButton.icon(
            onPressed: () {
              loggoutAlert(context);
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                textStyle: MaterialStateProperty.resolveWith((states) =>
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                elevation: MaterialStateProperty.all(10),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.0)))),
          )
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
