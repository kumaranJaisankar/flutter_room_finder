import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addVerticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

void showErrorSnakbar(
    String title, String message, SnackPosition snackPosition) {
  Get.snackbar(title, message,
      snackPosition: snackPosition,
      icon: Icon(Icons.error),
      backgroundColor: Colors.red[200],
      snackStyle: SnackStyle.GROUNDED);
}

void showSuccessSnakbar(
    String title, String message, SnackPosition snackPosition) {
  Get.snackbar(title, message,
      snackPosition: snackPosition,
      icon: Icon(Icons.done),
      backgroundColor: Colors.green[200],
      snackStyle: SnackStyle.GROUNDED);
}

PreferredSizeWidget navAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.green),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
