import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ping_pong_master/utils/commons.dart';
import 'package:ping_pong_master/views/auth/login_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void showErrorScreen(BuildContext context, String message) {
    setState(() => isLoading = false);

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(message),
              backgroundColor: Commons.popupItemBackColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        key: _pageKey,
        body: Form(
            key: _formPageKey,
            child: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                        _registerButton(),
                        _loginAccountLabel(),
                        Image.asset(
                          'assets/images/platform45.png',
                          width: 200,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }

  Widget _registerButton() {
    return isLoading
        ? Center(
            child: Commons.pingLoading("Registering new user..."),
          )
        : GestureDetector(
            onTap: () async {
              if (_formPageKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  final newUser =
                      await _authFirebase.createUserWithEmailAndPassword(
                          email: _userEmail.text, password: _userPassword.text);
                  if (newUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                } catch (e) {
                  setState(() => isLoading = false);
                  Commons.showError(context, e.message);
                  _pageKey.currentState.showSnackBar(
                      SnackBar(content: Text("Could not register.")));
                }
              }
            },
            child: Container(
              child: Text(
                'Register Now',
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

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              'Login',
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
}
