import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/modules/home.dart';
import 'package:quran/shared/local/local.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    CacheHelper.getSettings();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/man.png",
          height: 220,
          width: 220,
          fit: BoxFit.fill,
        ),
      )),
    );
  }
}
