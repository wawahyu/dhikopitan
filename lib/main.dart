import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dhikopitan/landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhi Kopitan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Theme.of(context).platform == TargetPlatform.android
          ? InitApp()
          : LandingPage(),
    );
  }
}

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  firebaseInit() async {
    if (Firebase.apps.length < 1) {
      await Firebase.initializeApp(
        name: 'com.retsa.dhikopitan',
        options: FirebaseOptions(
          appId: '1:338118577883:android:445b63cd1c16be90d9c6fe',
          apiKey: 'AIzaSyDQX17i5L1dmnLo3-v2sjvRX2S5CYV9eeE',
          messagingSenderId: '338118577883',
          projectId: 'retsa-project',
        ),
      ).catchError((onError) {});
    } else {}
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LandingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
