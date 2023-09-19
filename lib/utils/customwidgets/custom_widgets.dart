import 'package:flutter/material.dart';

import '../../../../constants/color_contatnts.dart';

TextFormField customTextField(
    String label,
    String hintText,
    IconData prefixIcon,
    String initialValue,
    bool enabled,
    TextEditingController fieldController) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'please enter ${label}';
      } else {
        null;
      }
      return null;
    },
    controller: fieldController..text = initialValue,
    enabled: enabled,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      label: Text(label),
      hintText: hintText,
      disabledBorder: OutlineInputBorder(),
      focusedErrorBorder: OutlineInputBorder(),
      errorBorder: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: secondaryColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green)),
    ),
  );
}
