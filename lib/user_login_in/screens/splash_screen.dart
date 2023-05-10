import 'dart:async';

import 'package:flutter/material.dart';

import '../../initial_data.dart';
import '../screen_decider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const id = '/splashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  SplashScreenState() {
    globalObj.getUser();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        Navigator.of(context, rootNavigator: true)
            .pushNamedAndRemoveUntil(ScreenDecider.id, (route) => false);
      });
    });
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: Center(
            child: Container(
              height: 140.0,
              width: 140.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: Image.asset(
                    'assets/tyianlogo.png',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
