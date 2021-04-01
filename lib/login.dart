import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Material( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign in with google or facebook",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => signInWithGoogle(), child: Text("Google")
          ),
          ElevatedButton(
              onPressed: () => signInWithFacebook(), child: Text("Facebook")
          ),
          ElevatedButton(
              onPressed: () => onPressLogout(), child: Text("logout")
          )
        ],
      ),
    );
  }

  void onPressLogout() async {
    await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null)
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      Navigator.pushReplacementNamed(context, "/");
  }

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    checkSigned(userCredential);  
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow    
    await FacebookAuth.instance.logOut();
    LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email']);        
    // print("TIEN: " + loginResult.message);    
    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken.token);

    // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      checkSigned(userCredential);
    } else {
      print("Login failed");
    }
    // Create a credential from the access token        
  }

  checkSigned(UserCredential userCredential){
    if (userCredential.user != null) {
          print(userCredential.user?.email);
          Navigator.pushReplacementNamed(context, '/welcome');
    } else {
          print("error when signing");
    }  
  }
}
