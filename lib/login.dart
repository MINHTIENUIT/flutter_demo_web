import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign in with google",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => onPressSignIn(), child: Text("Google"))
        ],
      ),
    );
  }

  onPressSignIn() async {
    await _googleSignIn.signOut();
    GoogleSignInAccount account = await _googleSignIn.signIn();
    if (account != null) {
      print(account.email);
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      print("Failed to sign in");
    }
  }
}
