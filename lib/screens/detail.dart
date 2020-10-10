import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) print(arguments['url']);
    return Scaffold(
      appBar: AppBar(
        title: Text(' Detail'),
      ),
      body: WebView(
        initialUrl: arguments['url'],
      ),
    );
  }
}
