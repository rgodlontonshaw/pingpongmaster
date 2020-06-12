import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ping_pong_master/utils/commons.dart';
import 'package:ping_pong_master/views/auth/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authFirebase = FirebaseAuth.instance;
  bool _obscureText = true;
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 14.0);
  TextEditingController _userEmail;
  TextEditingController _userPassword;
  final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _userEmail = TextEditingController(text: "");
    _userPassword = TextEditingController(text: "");
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        key: _pageKey,
        body: Form(
          key: _formPageKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                      child: Image.asset(
                        'assets/images/tabletennislogo.png',
                        width: 150,
                        height: 150,
                      )),
                  Text(
                    "Ping Pong Master",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _emailPasswordWidget(),
                  _loginButton(),
                  _forgotPassword(),
                  SizedBox(
                    height: 20,
                  ),
                  _skipButton(),
                  _createAccountLabel(),
                  Image.asset(
                    'assets/images/platform45.png',
                    width: 200,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _loginButton() {
    return isLoading
        ? Center(
            child: Commons.pingLoading("Logging in..."),
          )
        : GestureDetector(
            onTap: () async {
              if (_formPageKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  final newUser =
                      await _authFirebase.signInWithEmailAndPassword(
                          email: _userEmail.text, password: _userPassword.text);
                  print(newUser.toString());
                  if (newUser != null) {
                    _login();
                  }
                } catch (e) {
                  Commons.showError(context, e.message);
                  setState(() => isLoading = false);
                  _pageKey.currentState.showSnackBar(
                      SnackBar(content: Text("Could not login.")));
                }
              }
            },
            child: Container(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Commons.gradientBackgroundColorStart,
                        Commons.gradientBackgroundColorEnd
                      ])),
            ),
          );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {
        if (_userEmail.text != "") resetPassword(_userEmail.text);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text('Forgot Password ?',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _skipButton() {
    return GestureDetector(
      onTap: () {
        _login();
      },
      child: Container(
        child: Text(
          'Skip Login',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Commons.gradientBackgroundColorStart,
                  Commons.gradientBackgroundColorEnd
                ])),
      ),
    );
  }

  _login() {
    final storage = FlutterSecureStorage();
    storage.write(key: "loginstatus", value: "loggedin");
    //    Navigator.pushReplacement(
    //        context,
    //        MaterialPageRoute(
    //            builder: (BuildContext context) => InitializeProviderDataScreen()));
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Commons.mainAppFontColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      key: Key("userEmail"),
      controller: _userEmail,
      validator: (value) => (value.isEmpty) ? "Please Enter Email" : null,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "Email",
          border: OutlineInputBorder()),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      key: Key("userPassword"),
      controller: _userPassword,
      obscureText: _obscureText,
      validator: (value) => (value.isEmpty) ? "Please Enter Password" : null,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
          border: OutlineInputBorder()),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _emailField(),
        SizedBox(
          height: 10,
        ),
        _passwordField(),
        FlatButton(
            onPressed: _togglePassword,
            child: new Text(_obscureText ? "Show" : "Hide")),
      ],
    );
  }

  Future<void> resetPassword(String email) async {
    await _authFirebase.sendPasswordResetEmail(email: email);
  }
}
