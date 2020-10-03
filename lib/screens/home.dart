import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todayinhistory/constants/global.dart';

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
      appBar: AppBar(
        title: Text('TIH'),
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
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Year : ${data[index]['year']}'),
              subtitle: Text(data[index]['text']),
              trailing: IconButton(
                icon: Icon(Icons.open_in_new),
                onPressed: () {},
              ),
            );
          }),
    );
  }
}
