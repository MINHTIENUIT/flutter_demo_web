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
  UserProfile userProfile = UserProfile();

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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${userProfile.name}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${userProfile.email}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${userProfile.token}",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: onPressLogout, child: Text("Logout"))
                ],
              ),
            )
          : Center(),
    );
  }

  void onPressLogout() async {
    await _googleSignIn.signOut();
    bool isSigned = await _googleSignIn.isSignedIn();
    if (!isSigned) {
      await _googleSignIn.signOut();
    }
    Navigator.pushReplacementNamed(context, "/");
  }

  void getProfile() async {
    bool isSigned = await _googleSignIn.isSignedIn();
    if (isSigned) {
      account = await _googleSignIn.signInSilently();
      authen = await account.authentication;
      userProfile.email = account.email;
      userProfile.name = account.displayName;
      userProfile.token = authen.accessToken;
    }
    // authen = await account.authentication;

    setState(() {
      gotProfile = true;
    });
  }
}

class UserProfile {
  var email;
  var name;
  var token;
}
