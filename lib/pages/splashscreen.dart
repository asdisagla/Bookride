import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/tabbar.dart';
import 'package:flutter_finance_app/theme/colors.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  screenmove() async {
    Timer(
        Duration(seconds:5 ),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Tabbar())));
  }
  @override
  void initState() {
    screenmove();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 250,
            width: 250,
            child:Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
