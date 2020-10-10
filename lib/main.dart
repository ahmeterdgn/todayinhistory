import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todayinhistory/constants/theme.dart';
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
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themes = prefs.getBool('theme') ?? false;
    });
  }

  var themes = false;

  @override
  Widget build(BuildContext context) {
    print(themes);
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => themes == true
          ? ThemeChanger(ThemeData.light())
          : ThemeChanger(ThemeData.dark()),
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => IntroPage(),
      },
    );
  }
}
