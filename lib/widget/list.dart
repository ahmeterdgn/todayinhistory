import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:todayinhistory/constants/global.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({
    Key key,
    @required this.controller,
    @required this.bolum,
    @required this.datetime,
  }) : super(key: key);

  final ScrollController controller;
  final String bolum;
  final DateTime datetime;
  @override
  _ListHistoryState createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  @override
  void initState() {
    super.initState();
    fetch(bolum: widget.bolum);
  }

  var data = [];
  var jsonData;

  fetch({bolum}) async {
    var response = await http.get(
        '$globalUrl/${widget.datetime.month.toString()}/${widget.datetime.day.toString()}');

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      for (var i = 0; i < jsonData['data'][bolum].length; i++) {
        setState(() {
          data.add({
            'text': jsonData['data'][bolum][i]['text'],
            'year': jsonData['data'][bolum][i]['year'],
            'link': jsonData['data'][bolum][i]['links']
          });
        });
      }
    } else {
      print('Veri alamadı');
    }
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      // reverse: true,
      controller: widget.controller,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: {
              'url': data[data.length - 1 - index]['link'][0]['link']
            });
          },
          title: Text(
              'Year : ${data[data.length - 1 - index]['year'].toString()}'),
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
      },
    );
  }
}
