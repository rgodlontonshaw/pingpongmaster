import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ping_pong_master/views/HomePage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Ping Pong Master App', home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
            child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/tabletennislogo.png',
                width: 250,
                height: 250,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/platform45.png',
                width: 250,
                height: 150,
              ),
            ),
          ],
        )));
  }
}
