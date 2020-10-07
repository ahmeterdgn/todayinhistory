import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var themes = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          onChanged: (bool value) {
            setState(() {
              themes = value;
            });
          },
          value: themes,
        ),
      ],
    );
  }
}
