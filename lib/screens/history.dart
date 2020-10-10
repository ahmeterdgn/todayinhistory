import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todayinhistory/constants/global.dart';
import 'package:todayinhistory/screens/detail.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
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
  final controller = ScrollController();

  DateTime datetime = DateTime.now();

  fetch() async {
    var response = await http.get(
        '$globalUrl/${datetime.toString().substring(5, 10).replaceAll('-', '/')}');

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
      appBar: ScrollAppBar(
        controller: controller,
        centerTitle: true,
        title: Column(
          children: [
            Text('Choose date'),
            Text(
              datetime.toString().substring(5, 10).replaceAll('-', '/'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2222),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  helpText: 'Only Month and Day Will Work.',
                  currentDate: DateTime.now(),
                ).then((value) {
                  setState(() {
                    datetime = value == null ? DateTime.now() : value;
                    data.clear();
                    fetch();
                  });
                });
              })
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
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
            bolum = i == 1
                ? 'Events'
                : i == 2
                    ? 'Births'
                    : 'Deaths';
            data.clear();
            fetch();
          });
        },
      ),
      body: ListView.builder(
          // reverse: true,
          controller: controller,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      url: data[data.length - 1 - index]['link'][0]['link'],
                    ),
                  ),
                );
              },
              title: Text('Year : ${data[data.length - 1 - index]['year']}'),
              subtitle: Text(
                data[data.length - 1 - index]['text'],
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.share,
                  size: 18,
                ),
                onPressed: () {
                  Share.share(
                      '${data[data.length - 1 - index]['text']}  link : ${data[data.length - 1 - index]['link'][0]['link']}');
                },
              ),
            );
          }),
    );
  }
}
