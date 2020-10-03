import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todayinhistory/constants/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  bool _swipe = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  bool _proportionalChildArea = true;
  double _horizontalOffset = 0.8;
  double _verticalOffset = 0.8;
  double _scale = 0.9;
  double _borderRadius = 50;
  Color currentColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      onTapClose: true,
      offset: IDOffset.only(
        bottom: _verticalOffset,
        right: _horizontalOffset,
        left: _horizontalOffset,
      ),
      scale: IDOffset.horizontal(_scale),
      borderRadius: _borderRadius,
      duration: Duration(milliseconds: 11200),
      swipe: _swipe,
      proportionalChildArea: _proportionalChildArea,
      colorTransitionChild: currentColor,
      leftAnimationType: _animationType,
      rightAnimationType: _animationType,
      leftChild: Material(
          color: Colors.red[400],
          child: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Image",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )),
          )),
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('TIH'),
          actions: [
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _animationType = InnerDrawerAnimation.static;
                  });
                })
          ],
        ),
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
      ),
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
