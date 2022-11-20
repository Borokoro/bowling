import 'package:flutter/material.dart';
import 'package:bowling/bowling/bowling.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bowling',
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    home: const Bowling(),
  ));
}