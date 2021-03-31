import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static final String route = '/SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
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
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpLogo(){
    return Center(
      child: Text('Sign Up', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
    );
  }

  Widget form(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            signUpLogo(),
            SizedBox(height: 40,),
            Text('Your Name'),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Type your name',
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Email'),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Type your email',
                    prefixIcon: Icon(Icons.account_circle),
                    border: UnderlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Password'),
            Container(
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Type your password',
                    prefixIcon: Icon(Icons.vpn_key),
                    border: UnderlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Password Confirm'),
            Container(
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Type your password again',
                    prefixIcon: Icon(Icons.vpn_key),
                    border: UnderlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 40,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    )
                  ),
                  onPressed: (){},                  
                  child: Text('SIGN UP', style: TextStyle(color: Colors.white),),                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}