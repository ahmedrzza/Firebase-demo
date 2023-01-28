import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseproject/screen/authentication/login_Screen.dart';
import 'package:flutterfirebaseproject/screen/firebase_database/post_Screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}


class _Splash_ScreenState extends State<Splash_Screen> {
  login(context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null){
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          (MaterialPageRoute(
            builder: (context) =>const Post_Screen(),
          )),
        ),
      );
    }else{
       Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          (MaterialPageRoute(
            builder: (context) =>const Login_Screen(),
          )),
        ),
      );
    }
   
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
