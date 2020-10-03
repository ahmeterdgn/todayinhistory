import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todayinhistory/constants/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  var data = [];
  var isLoading = true;
  var jsonData;
  var jsonDataAll;
  var bolum = 'Events';
  fetch() async {
    var response = await http.get(globalUrl);

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      jsonDataAll = jsonData['data'][bolum];
      for (var i = 0; i < jsonDataAll.length; i++) {
        setState(() {
          data.add({
            'text': jsonDataAll[i]['text'],
            'year': jsonDataAll[i]['year'],
            'link': jsonDataAll[i]['links']
          });
          isLoading = false;
        });
      }
    } else {
      print('Veri alamadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.red[400],
        elevation: 5,
        // cornerRadius: 5,
        items: [
          TabItem(
            icon: FontAwesomeIcons.bookDead,
            title: 'Deaths',
          ),
          TabItem(
            icon: Icons.event,
            title: 'Events',
          ),
          TabItem(
            icon: FontAwesomeIcons.birthdayCake,
            title: 'Birthday',
          ),
        ],
        initialActiveIndex: 1, //optional, default as 0
        onTap: (int i) {
          setState(() {
            bolum = i == 1 ? 'Events' : i == 2 ? 'Births' : 'Deaths';
            data.clear();
            fetch();
          });
        },
      ),
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Year : ${data[index]['year']}'),
              subtitle: Text(data[index]['text']),
              trailing: IconButton(
                icon: Icon(Icons.open_in_new),
                onPressed: () {
                  _launchURL(url: data[index]['link'][0]['link']);
                },
              ),
            );
          }),
    );
  }

  _launchURL({url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
