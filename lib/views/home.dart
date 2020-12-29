import 'package:flutter/material.dart';
import 'package:todayinhistory/widgets/list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            tabs: [
              Tab(
                text: "Events",
                icon: Icon(Icons.date_range_outlined),
              ),
              Tab(
                text: "Deaths",
                icon: Icon(Icons.chat),
              ),
              Tab(
                text: "Births",
                icon: Icon(Icons.insert_emoticon_outlined),
              )
            ],
            controller: _tabController,
          ),
          title: Text("TIH"),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListWidget(
              type: "events",
            ),
            ListWidget(
              type: "deaths",
            ),
            ListWidget(
              type: "births",
            ),
          ],
        ));
  }
}
