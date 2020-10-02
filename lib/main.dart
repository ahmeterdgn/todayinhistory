import 'package:flutter/material.dart';
import 'package:todayinhistory/screens/home.dart';
import 'package:todayinhistory/screens/intro.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => IntroPage(),
      },
    );
  }
}
