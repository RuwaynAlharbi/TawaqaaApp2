import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Adv.dart';

/*
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(Adv());
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5B5B5B), // اللون الرمادي الداكن
              Color(0xFFE5E4E4), // اللون الرمادي الفاتح
              Color(0xFF5B5B5B), // اللون الرمادي الداكن مرة أخرى
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/logotwob.png', // إضافة الصورة
                width: 360, // عرض اللوقو
                height: 200, // ارتفاع اللوقو
              ),
              SizedBox(height: 20), // مسافة بين اللوقو والنص
              Text(
                'حياتك تهمنا',
                style: TextStyle(
                  fontSize: 30, // حجم الخط
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Start the timer to navigate to the 'Adv' screen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Get.to(Adv()); // Navigate to Adv after 2 seconds
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5B5B5B), // Dark gray
              Color(0xFFE5E4E4), // Light gray
              Color(0xFF5B5B5B), // Dark gray again
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/logotwob.png', // Logo image
                width: 360,
                height: 200,
              ),
              SizedBox(height: 20), // Space between logo and text
              Text(
                'حياتك تهمنا',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
