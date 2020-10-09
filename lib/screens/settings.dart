import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todayinhistory/constants/global.dart';
import 'package:todayinhistory/constants/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var themes = false;
  var dark = false;
  var light = true;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', themes);
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themes = prefs.getBool('theme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Column(
      children: [
        Radio(
          value: dark,
          groupValue: themes,
          onChanged: (bool value) {
            setState(
              () {
                dark = value;
                _themeChanger.setTheme(ThemeData.light());
              },
            );
          },
        ),
        Radio(
          value: light,
          groupValue: themes,
          onChanged: (bool value) {
            setState(
              () {
                light = value;
                _themeChanger.setTheme(ThemeData.light());
              },
            );
          },
        ),
        FlatButton(
          onPressed: () => _themeChanger.setTheme(ThemeData.dark()),
          child: Text('dark'),
        ),
        FlatButton(
          onPressed: () => _themeChanger.setTheme(ThemeData.light()),
          child: Text('light'),
        ),
      ],
    );
  }
}
