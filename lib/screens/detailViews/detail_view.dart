import 'package:dotted_border/dotted_border.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:developer';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key, required this.room});
  final Rooms room;

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    EasyLoading.showSuccess('SUCCESS PAYMENT : ${response.paymentId}',
        dismissOnTap: true, duration: Duration(seconds: 4));
    log('payment success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    EasyLoading.showError('ERROR HERE : ${response.message}',
        dismissOnTap: true, duration: Duration(seconds: 4));
    log('payment failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    EasyLoading.showSuccess('WALLET TYPE : ${response.walletName}',
        dismissOnTap: true, duration: Duration(seconds: 4));
    log('handle external wallets');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay?.clear();
  }

  void makePayment() async {
    var options = {
      'key': 'rzp_test_fClsajQLt9rHx3',
      'amount': widget.room.price * 100, //in the smallest currency sub-unit.
      'name': 'Room Finder',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': widget.room.roomName,
      'timeout': 300,
      'prefill': {'contact': '9092296765', 'email': 'kumaranhb5@gmail.com'},
      'theme': {
        'hide_topbar': false,
        'color': '#32C615',
        'backdrop_color': '#32C615'
      },
      'modal': {'confirm_close': true}
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    print(widget.room.geoLocation.latitude);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  addVerticalSpacer(20.0),
                  Center(
                    child: Card(
                      color: Get.isDarkMode ? null : Colors.green[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Hero(
                              tag: widget.room.id,
                              child: Image.network(
                                widget.room.imgUrl,
                                width: double.maxFinite,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            addVerticalSpacer(10.0),
                            ListTile(
                              title: Text(
                                widget.room.roomName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Badge(
                                      smallSize: 10.0,
                                      backgroundColor: widget.room.isAvalibale
                                          ? Colors.green
                                          : Colors.red),
                                  addHorizontalSpacer(5.0),
                                  Text(widget.room.isAvalibale
                                      ? 'avaliable'
                                      : 'unavaliable')
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    addHorizontalSpacer(10.0),
                                    Icon(Icons.location_on,
                                        color: Get.isDarkMode
                                            ? Colors.green.shade200
                                            : Colors.black45),
                                    addHorizontalSpacer(10.0),
                                    Text(
                                      widget.room.location,
                                      style: TextStyle(fontSize: 15.0),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Text(
                                        widget.room.rating.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            addVerticalSpacer(10.0),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              padding: EdgeInsets.all(6.0),
                              radius: Radius.circular(10.0),
                              child: Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      zoom: 11,
                                      target: LatLng(
                                          widget.room.geoLocation.latitude,
                                          widget.room.geoLocation.longitude)),
                                  markers: {
                                    Marker(
                                        markerId:
                                            MarkerId(widget.room.location),
                                        position: LatLng(
                                            widget.room.geoLocation.latitude,
                                            widget.room.geoLocation.longitude),
                                        draggable: true,
                                        onDragEnd: (value) {
                                          // value is the new position
                                        },
                                        infoWindow: InfoWindow(
                                            title: 'Room finder',
                                            snippet:
                                                '${widget.room.roomName} house avalibale here'),
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueRose)),
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpacer(20.0),
                  Text('Checkout:'),
                  ElevatedButton.icon(
                      onPressed: widget.room.isAvalibale
                          ? (() => makePayment())
                          : null,
                      icon: Icon(Icons.currency_rupee),
                      label: Text(widget.room.price.toString()))
                ]),
          ),
        ),
      ),
    );
  }
}
