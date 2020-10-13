import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todayinhistory/constants/theme.dart';
import 'package:todayinhistory/screens/detail.dart';
import 'package:todayinhistory/screens/home.dart';
import 'package:todayinhistory/screens/intro.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
    // The top level function, aka callbackDispatcher
    callbackDispatcher,

    // If enabled it will post a notification whenever
    // the task is running. Handy for debugging tasks
    isInDebugMode: true,
  );
  // Periodic task registration
  Workmanager.registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: Duration(minutes: 15),
  );
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
    0,
    'GeeksforGeeks',
    'Your are one step away to connect with GeeksforGeeks',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themes = prefs.getBool('theme') ?? false;
    });
  }

  var themes = false;

  @override
  Widget build(BuildContext context) {
    print(themes);
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => themes == true
          ? ThemeChanger(ThemeData.light())
          : ThemeChanger(ThemeData.dark()),
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => IntroPage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}
