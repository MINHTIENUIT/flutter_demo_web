import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool gotProfile = false;
  UserProfile userProfile = UserProfile();

  @override
  void initState() {    
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
                  Expanded(
                    child: Text(
                    "${userProfile.token}",
                    style: TextStyle(fontSize: 20),
                    )
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
    await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null)
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      Navigator.pushReplacementNamed(context, "/");
  }

  void getProfile() async {    
    if (FirebaseAuth.instance.currentUser != null) {
      var account = FirebaseAuth.instance.currentUser;      

      userProfile.email = account?.email;
      userProfile.name = account?.displayName;            
      userProfile.token = await account?.getIdToken();
      print(userProfile.token);
    }    

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
