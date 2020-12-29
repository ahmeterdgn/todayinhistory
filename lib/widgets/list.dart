import 'package:flutter/material.dart';
import 'package:todayinhistory/functions/globals.dart';
import 'package:todayinhistory/views/detail.dart';

class ListWidget extends StatefulWidget {
  final type;
  ListWidget({Key key, this.type}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  var result;

  query() async {
    result = await server(widget.type);
    setState(() {
      result = result;
    });
  }

  @override
  void initState() {
    super.initState();
    query();
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? ListView.builder(
            itemCount: result[widget.type].length,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        url: result[widget.type][index]["wikipedia"][0]
                            ["wikipedia"],
                        title: result[widget.type][index]["wikipedia"][0]
                            ["title"],
                      ),
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
                    title: Text("Year : " + result[widget.type][index]["year"]),
                    subtitle: Text(result[widget.type][index]["description"]),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
