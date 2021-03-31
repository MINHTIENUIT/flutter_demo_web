import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    await FirebaseAuth.instance.signOut();
      
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.pushReplacementNamed(context, "/");
  }

  void getProfile() async {
    User account = FirebaseAuth.instance.currentUser;
    if (account != null) {            
      userProfile.email = account.email;
      userProfile.name = account.displayName;
      userProfile.token = account.getIdToken();
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
