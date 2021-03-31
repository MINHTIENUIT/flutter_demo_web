package com.example.demo_flutter_web

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {    
    override fun configureFlutterEngine(flutterEngine:FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    
    }    
}
