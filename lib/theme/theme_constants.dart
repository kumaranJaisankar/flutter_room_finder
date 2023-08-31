import 'package:flutter/material.dart';

//light theme data's
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.green.shade100.withOpacity(0.3),
  colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.green),
  inputDecorationTheme: const InputDecorationTheme(
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      labelStyle: TextStyle(color: Colors.green)),
  iconTheme: IconThemeData(color: Colors.green),
);

//dark theme data's
ThemeData darkTheme = ThemeData(
    colorScheme: ThemeData.dark().colorScheme.copyWith(primary: Colors.green),
    primaryColor: Colors.green,
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style:
    //       ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
    // ),
    // appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 87, 179, 64),
        foregroundColor: Colors.white),
    // colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
    brightness: Brightness.dark);
