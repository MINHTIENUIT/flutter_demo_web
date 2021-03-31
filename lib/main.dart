import 'package:demo_flutter_web/signup.dart';
import 'package:demo_flutter_web/welcome.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'splash.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/welcome': (_) => WelcomeScreen(),
        '/signup': (_) => SignUpPage()
      },
    );
  }
}
