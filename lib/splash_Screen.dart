import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseproject/login_Screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  login(context) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        (MaterialPageRoute(
          builder: (context) => Login_Screen(),
        )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'FireBase tutorial',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
