import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary =Color.fromRGBO(66, 55, 196, 1);
 
  static const backgroundColor = Color.fromRGBO(231, 231, 237, 1);
  static const secondColor = Colors.grey;
  static const subtitles = Colors.grey;

  static const subtitleStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //color primario
    primaryColor: const Color.fromRGBO(66, 55, 196, 1),

    scaffoldBackgroundColor: backgroundColor,

    scrollbarTheme: ScrollbarThemeData(
      showTrackOnHover: false,
      thumbColor: MaterialStateProperty.all(AppTheme.primary.withOpacity(0.4)),
      thickness: MaterialStateProperty.all(5.0),
    ),

    //appbar theme
    appBarTheme: const AppBarTheme(
        toolbarHeight: 100,
        color: backgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35)),
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary, elevation: 5),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: primary, shape: const StadiumBorder(), elevation: 0)),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),


    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
    ),
  );
}
