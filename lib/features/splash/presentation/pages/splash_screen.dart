import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Fade in animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
    // Navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Image.asset('assets/images/img_2.png',

            ),
          ),
        ),
      ),
    );
  }
}