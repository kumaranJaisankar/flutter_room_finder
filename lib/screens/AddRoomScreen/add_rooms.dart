// import 'package:file_picker/file_picker.dart';
// ignore_for_file: empty_constructor_bodies

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/screens/home_page.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../models/user_model.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({super.key});

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  bool _isAvalibale = false;

  List<GeoPointLocations> _dropDownList = [
    GeoPointLocations(
        district: 'Chennai',
        geoLocation: GeoPoint(13.088786531382837, 80.25148543577652)),
    GeoPointLocations(
        district: 'Hydrabad',
        geoLocation: GeoPoint(17.397663490182897, 78.4930931490127)),
    GeoPointLocations(
        district: 'Kerala',
        geoLocation: GeoPoint(9.429691279588464, 76.81240552828399)),
    GeoPointLocations(
        district: 'Delhi',
        geoLocation: GeoPoint(28.37162137510285, 77.33561679493853)),
    GeoPointLocations(
        district: 'Bengaluru',
        geoLocation: GeoPoint(13.389303761951108, 77.53925495193958)),
  ];

  bool _isLoading = false;
  GeoPoint _geoPoint = const GeoPoint(17.395014891958805, 78.4837290202236);

  String? _location = 'chennai';

  PlatformFile? pickedFile;
  UploadTask? imageUpload;

  TextEditingController roomName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController location = TextEditingController();

  Future openFileMAnage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future addRoomToFirebase() async {
    setState(() {
      _isLoading = true;
    });

    final paths = pickedFile!.name;
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(paths);
    imageUpload = ref.putFile(file);

    final snapshot = await imageUpload!.whenComplete(() {});

    final getDownloadUrl = await snapshot.ref.getDownloadURL();

    final docSet = FirebaseFirestore.instance.collection('rooms').doc();

    final roomDetail = Rooms(
        id: docSet.id,
        roomName: roomName.text,
        price: int.parse(price.text),
        location: _location!,
        isAvalibale: _isAvalibale,
        imgUrl: getDownloadUrl,
        geoLocation: _geoPoint);
    final json = roomDetail.toJson();
    await docSet.set(json);
    Toast.show("added successfuly!!",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    setState(() {
      _isLoading = false;
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: navAppBar(),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => openFileMAnage(),
                        child: DottedBorder(
                          padding: const EdgeInsets.all(5.0),
                          // dashPattern: [6, 3, 2, 3],
                          color: Colors.green,
                          borderType: BorderType.RRect,
                          // borderPadding: EdgeInsets.all(15.0),
                          radius: const Radius.circular(10.0),
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.withOpacity(0.2),
                                image: pickedFile != null
                                    ? DecorationImage(
                                        image:
                                            FileImage(File(pickedFile!.path!)),
                                        fit: BoxFit.cover)
                                    : null),
                            child: Center(
                              child: TextButton(
                                  onPressed: () async {
                                    openFileMAnage();
                                  },
                                  child: const Text('Uplode image')),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: roomName,
                        decoration: const InputDecoration(
                            prefixIconColor: Colors.green,
                            prefixIcon: Icon(Icons.home_filled),
                            hintText: 'Enter your room type',
                            labelText: 'Room Name'),
                      ),
                      addVerticalSpacer(10.0),
                      TextFormField(
                        controller: price,
                        decoration: const InputDecoration(
                            prefixIconColor: Colors.green,
                            prefixIcon: Icon(Icons.price_check),
                            hintText: 'Enter your room price',
                            labelText: 'Price'),
                      ),
                      addVerticalSpacer(10.0),
                      // TextFormField(
                      //   controller: location,
                      //   decoration: const InputDecoration(
                      //       prefixIconColor: Colors.green,
                      //       prefixIcon: Icon(Icons.location_on),
                      //       hintText: 'Enter your room location',
                      //       labelText: 'Location'),
                      // ),
                      // addVerticalSpacer(15.0),
                      DropdownButtonFormField(
                        items: _dropDownList
                            .map((e) => DropdownMenuItem(
                                child: Text(e.district!), value: e))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _location = val!.district;
                            _geoPoint = val.geoLocation!;
                          });
                          ;
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.green,
                        ),
                        decoration: InputDecoration(
                            label: Text(' Select Location'),
                            prefixIcon: Icon(Icons.location_on),
                            prefixIconColor: Colors.green),
                      ),
                      addVerticalSpacer(15.0),
                      CheckboxListTile(
                        value: _isAvalibale,
                        onChanged: (val) {
                          setState(() {
                            _isAvalibale = val!;
                          });
                        },
                        activeColor: Colors.green,
                        title: const Text('Room Avaliabale'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      addVerticalSpacer(20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              addRoomToFirebase();
                            },
                            style: const ButtonStyle(),
                            child: const Text('ADD ROOM')),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final String? items =
                                  await prefs.getString('UserDetail');
                              Users userMap =
                                  Users.fromJson(jsonDecode(items!));
                              print(items);
                              print(userMap);
                              print(userMap.id);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('Testing 😯'))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class GeoPointLocations {
  String? district;
  GeoPoint? geoLocation;

  GeoPointLocations({required this.district, required this.geoLocation});
}
