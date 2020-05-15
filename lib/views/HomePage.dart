import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
            child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 120, 0, 100),
                        child: Image.asset(
                          'assets/images/tabletennislogo.png',
                          width: 250,
                          height: 250,
                        )),
                    Container(
                        width: 300,
                        child: FlatButton(
                          color: const Color(0xFF1c2a6e),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                        )),
                    Container(
                        width: 300,
                        child: FlatButton(
                          color: const Color(0xFFf1f5fb),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {},
                        ))
                  ],
                )),
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
