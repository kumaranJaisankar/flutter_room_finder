import 'package:fire_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loggoutAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return AlertDialog(
        title: const Text('Do you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              Get.back();
              // Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'YES',
            ),
            onPressed: () {
              AuthController.instance.logout();
            },
          )
        ],
      );
    },
  );
}
