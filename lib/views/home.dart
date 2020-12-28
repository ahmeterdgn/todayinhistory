import 'package:flutter/material.dart';
import 'package:todayinhistory/functions/globals.dart';
import 'package:todayinhistory/views/detail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;

  @override
  void initState() {
    super.initState();
    query();
  }

  query() async {
    result = await server();
    setState(() {
      result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TIH"),
      ),
      body: result != null
          ? ListView.builder(
              itemCount: result["data"]["Events"].length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(),
                      ),
                    );
                  },
                  splashColor: Colors.deepPurple,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(result["data"]["Events"][index]["text"]),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
