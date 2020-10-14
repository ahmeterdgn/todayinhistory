import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:todayinhistory/widget/list.dart';

// ignore: must_be_immutable
class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = ScrollController();
  var controller2;
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: ScrollAppBar(
          controller: controller,
          title: TabBar(
            controller: controller2,
            tabs: [
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    Text('adasd'),
                  ],
                ),
              ),
              Tab(
                text: 'adasd',
              ),
              Tab(
                text: 'adasd',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
              });
            });
          },
          child: Icon(Icons.date_range),
        ),
        body: TabBarView(
          controller: controller2,
          children: [
            ListHistory(
              controller: controller,
              bolum: 'Births',
              datetime: datetime,
            ),
            ListHistory(
              controller: controller,
              bolum: 'Events',
              datetime: datetime,
            ),
            ListHistory(
              controller: controller,
              bolum: 'Deaths',
              datetime: datetime,
            ),
          ],
        ),
      ),
    );
  }
}
