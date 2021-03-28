import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount account;
  GoogleSignInAuthentication authen;
  bool gotProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: gotProfile
          ? Column(
              children: [
                Text(
                  "Welcome to the App",
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(onPressed: onPressLogout, child: Text("Logout"))
              ],
            )
          : Center(
              child: ElevatedButton(
                  onPressed: onPressLogout, child: Text("Logout"))),
    );
  }

  void onPressLogout() async {
    await _googleSignIn.signOut();
    bool isSigned = await _googleSignIn.isSignedIn();
    if (!isSigned) {
      Navigator.pushReplacementNamed(context, "/");
    } else {
      print("Error when logout");
    }
  }

  void getProfile() async {
    account = await _googleSignIn.onCurrentUserChanged.first;
    authen = await account.authentication;

    setState(() {
      gotProfile = true;
    });
  }
}
