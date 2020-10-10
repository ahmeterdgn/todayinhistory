import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todayinhistory/constants/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var themes = false;

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
        ListTile(
          title: Text('Dark Theme'),
          trailing: Switch(
              value: themes,
              onChanged: (theme) {
                themes == false
                    ? _themeChanger.setTheme(ThemeData.dark())
                    : _themeChanger.setTheme(ThemeData.light());
                setState(() {
                  themes = theme;
                  setdata();
                });
              }),
        ),
      ],
    );
  }
}
