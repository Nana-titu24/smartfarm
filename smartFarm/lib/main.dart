import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart'; // Make sure the flutter_gemini package is installed
import 'dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Gemini
  Gemini.init(
    apiKey: 'AIzaSyDZu8o67zJyLeus-kyq53EjCKocc-Wi91s',
  );
  
  // Initialize Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC7NHmajgeYlbU03PJ8WbOJYa4SztEa2Fw",
        appId: "1:355240987985:android:f256be5591992a7e885770",
        messagingSenderId: "355240987985",
        projectId: "agrisfa",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMARTFARM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SMART FARM'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Welcome to SMART FARM',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
