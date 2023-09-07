// import 'package:file_picker/file_picker.dart';
// ignore_for_file: empty_constructor_bodies

import 'dart:io';
import 'package:fire_flutter/screens/AddRoomScreen/helperwidget/rating_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({super.key});

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
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

  bool _isAvalibale = false;
  // bool _isLoading = false;
  GeoPoint _geoPoint = const GeoPoint(17.395014891958805, 78.4837290202236);
  double? ratingStar = 1.0;
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
    EasyLoading.show();

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
        geoLocation: _geoPoint,
        rating: ratingStar!);
    final json = roomDetail.toJson();
    await docSet.set(json);
    Toast.show("added successfuly!!",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    EasyLoading.dismiss();
    Get.back();
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
          child: Padding(
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
                                  image: FileImage(File(pickedFile!.path!)),
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
                      .map((e) =>
                          DropdownMenuItem(child: Text(e.district!), value: e))
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
                RoomRatingBar(onRating: (value) {
                  setState(() {
                    ratingStar = value;
                  });
                }),
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
                    onPressed: () {
                      var strs = {
                        "imgUrl":
                            "https://firebasestorage.googleapis.com/v0/b/my-portfolio-fe1ff.appspot.com/o/1bhk-wadala.jpg?alt=media&token=1031fbe9-ff49-4c90-86f7-3e1a1f3ca932",
                        "isAvalibale": true,
                        "geoLocation": {
                          'latitude': 25.62846608199264,
                          'longitude': 85.13447944266653
                        },
                        "price": 7000,
                        "rating": 3.5,
                        "location": "Hydrabad",
                        "id": "7tY6L6DWQk2QZbowzGlS",
                        "roomName": "1bhk"
                      };
                      strs['geoLocation'] = {'name': 'kumaran'};
                      print(strs);
                      // var poin = Rooms.geoPointJson(strs);
                      // // print(Rooms.fromJson(strs));
                      // print(poin.geoLocation.latitude);
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
