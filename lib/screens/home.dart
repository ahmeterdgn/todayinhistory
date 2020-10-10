import 'package:flutter/material.dart';
import 'package:todayinhistory/model/menu.dart';
import 'package:todayinhistory/screens/history.dart';
import 'package:todayinhistory/screens/settings.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenuItemId;
  @override
  void initState() {
    selectedMenuItemId = menu.items[0].id;
    super.initState();
  }

  var datetime;

  @override
  Widget build(BuildContext context) {
    print(datetime.toString().substring(5, 10).replaceAll('-', '/'));
    return DrawerScaffold(
      appBar: AppBar(
        title: Text("Today In History"),
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
                  helpText: 'Sadece Ay ve Gün İşleyecektir.',
                ).then((value) {
                  setState(() {
                    datetime = value;
                  });
                });
              })
        ],
      ),
      drawers: [
        SideDrawer(
          percentage: 0.6,
          menu: menu,
          direction: Direction.left,
          animation: true,
          background: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://i.pinimg.com/564x/8e/2e/98/8e2e9834124fc0a166532cb3765b5e3e.jpg",
            ),
          ),
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        )
      ],
      builder: (context, id) => IndexedStack(index: id, children: [
        HistoryPage(),
        SettingsPage(),
      ]),
    );
  }
}
