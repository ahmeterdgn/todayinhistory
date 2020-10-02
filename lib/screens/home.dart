import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
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
          print(data);
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
        items: [
          TabItem(
            icon: Icons.home,
            title: 'Deaths',
          ),
          TabItem(
            icon: Icons.map,
            title: 'Events',
          ),
          TabItem(
            icon: Icons.message,
            title: 'Births',
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
              title: Text(data[index]['year']),
              subtitle: Text(data[index]['text']),
            );
          }),
    );
  }
}
