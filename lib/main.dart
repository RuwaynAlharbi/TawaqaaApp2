import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:fluttertest/HomePage.dart'; // Correct import for HomePage
import 'package:fluttertest/Welcome.dart'; // Import for Welcome screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp instead of MaterialApp for GetX features
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Welcome(), // Set Welcome as the initial screen
    );
  }
}
