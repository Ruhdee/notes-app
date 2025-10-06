import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF985DA5);
final Color secondaryColor = const Color(0xFFFEC001);
final Color backgroundColor = const Color(0xFFFFF9F4);

ThemeData customTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
  cardColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: secondaryColor),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    foregroundColor: primaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: primaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: secondaryColor.withOpacity(0.15),
    labelStyle: TextStyle(color: primaryColor),
    selectedColor: primaryColor.withOpacity(0.2),
    disabledColor: Colors.grey,
    secondaryLabelStyle: TextStyle(color: secondaryColor),
    brightness: Brightness.light,
    padding: EdgeInsets.symmetric(horizontal: 8),
    shape: StadiumBorder(),
  ),
);
