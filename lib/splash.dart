import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    checkSignInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to App - splash page"),
          Divider(
            height: 20,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 2));
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      print("Signed");
      Navigator.pushReplacementNamed(context, "/welcome");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }
}
