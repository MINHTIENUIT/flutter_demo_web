import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
      'email',
    ],
    );

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(),
                form(),
                signUP(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginLogo() {
    // var height = MediaQuery.of(context).size.height;
    return Container(
      child: Text(
        'Login',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget form() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: loginLogo()),
              SizedBox(
                height: 40,
              ),
              Text('Email'),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Type your email',
                      prefixIcon: Icon(Icons.email),
                      border: UnderlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Password'),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Type your password',
                    prefixIcon: Icon(Icons.vpn_key),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      child: Text(
                        'Forgot password?',
                        textAlign: TextAlign.right,
                      ))),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(                  
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      )),                  
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(80))
                    )
                  ),
                  onPressed: () => {},
                ),
              ),
              otherLoginPlatform(),
            ],
          ),
        ),
      ),
    );
  }

  Widget otherLoginPlatform() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text('Or Sign In Using'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.indigo,
                ),
                onPressed: () => {onPressSignInWithFacebook()},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                onPressed: () => {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.redAccent,
                ),
                onPressed: () => {onPressSignInWithGoogle()},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget signUP() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Have not account yet?'),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {            
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      )
    );
  }

  onPressSignInWithGoogle() async {              

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    directlyWhenSigned(userCredential);
    
  }

  onPressSignInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    directlyWhenSigned(userCredential);
  }

  directlyWhenSigned(UserCredential credential) {
    if (credential != null) {
      print(credential.user.email);
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      print("login failed");
    }
  }
}
