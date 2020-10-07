import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var themes = false;
  @override
  void initState() {
    super.initState();
    data();
    getdata();
  }

  data() async {
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
    return Column(
      children: [
        Row(
          children: [
            Text('Theme'),
            Switch(
              onChanged: (bool value) {
                setState(() {
                  themes = value;
                  data();
                });
              },
              value: themes,
            ),
          ],
        ),
      ],
    );
  }
}
