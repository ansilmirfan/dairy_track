import 'package:flutter/material.dart';

class Themes {
  static var primary = Colors.blue;
  static var secondary = Colors.white;
  static var tertiary = const Color.fromARGB(255, 27, 73, 222);
  //-------linear gradiant-----
  static Decoration linearGradiantDecoration = const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      Color.fromARGB(255, 27, 73, 222),
      Color.fromARGB(255, 94, 87, 225),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ));
//---------border radius 10-----------
  static BorderRadius radius10 = BorderRadius.circular(10);
}
