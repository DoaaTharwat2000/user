import 'dart:async';

import 'package:bi_tracker_user/firebase/auth.dart';
import 'package:bi_tracker_user/screens/login.dart';
import 'package:bi_tracker_user/shared/constants.dart';
import 'package:bi_tracker_user/shared/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    Timer(const Duration(seconds: 2), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          navigateReplacement(context: context, route: const LogIn());
        } else {
          // Navigator.pushReplacementNamed(context, FirstScreen.id);

          checkLog(context, user.uid);
          setState(() {
            uid = user.uid;
          });

          //  print('User is signed in!');
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/logo.png",
            filterQuality: FilterQuality.high,
            height: 200,
          ),
          const CircularProgressIndicator()
        ],
      ),
    ));
  }
}
