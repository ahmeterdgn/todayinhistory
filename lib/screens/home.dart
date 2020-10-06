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

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: AppBar(
        title: Text("Today In History"),
        backgroundColor: Colors.red[400],
      ),
      drawers: [
        SideDrawer(
          percentage: 0.6,
          menu: menu,
          direction: Direction.left,
          animation: true,
          color: Colors.red,
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
