import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ping_pong_master/views/auth/login_screen.dart';

class Commons {
  static const baseURL = "https://api.chucknorris.io/";

  static const tileBackgroundColor = const Color(0xFFF1F1F1);
  static const gradientBackgroundColorEnd = const Color(0xFF1c2a6e);
  static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  static const mainAppFontColor = const Color(0xFF1c2a6e);
  static const appBarBackGroundColor = const Color(0xFF4D0F28);
  static const categoriesBackGroundColor = const Color(0xFFA8184B);
  static const hintColor = const Color(0xFF4D0F29);
  static const mainAppColor = const Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = const Color(0xFF1c2a6e);
  static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget pingLoader() {
    return Center(child: SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFF311433),
          ),
        );
      },
    ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(message),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static Widget pingLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(18), child: Text(message)),
        pingLoader(),
      ],
    );
  }

  static Future logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
