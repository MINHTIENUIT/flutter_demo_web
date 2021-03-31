import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {

  @override
  void initState() {
    Firebase.initializeApp();
    checkSignInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to App - splash page"),
                SizedBox(height: 20,),
                CircularProgressIndicator()
              ],
            ),
          );
        }
    );
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 2));
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print("Signed");
      Navigator.pushReplacementNamed(context, "/welcome");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }
}
