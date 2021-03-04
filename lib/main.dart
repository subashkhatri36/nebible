import 'dart:async';
import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/data/TodayVerse.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/screen/believer/believers.dart';
import 'package:nebible/screen/boarding/onbording.dart';
import 'package:nebible/screen/bookmark_screen/bookmark.dart';
import 'package:nebible/screen/main_home_screen/mainhomescreen.dart';
import 'package:nebible/screen/setting_screen/setting.dart';

import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  // Initialize without device test ids
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

//await _configureLocalTimeZone();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nebible',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/bookmark': (context) => Bookmarks(),
        '/dashboard': (context) => MainHomeScreen(),
        '/setting': (context) => Settings(),
        '/beliver': (context) => Believers(),
        // '/guitar': (context) => Guitar(pdfAssetPath: ''),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool onbording = true;
  String language = 'Nepali';

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    language = qry[0]['${DatabaseHelper.blanguge}'].toString();
  }

  int randomnumbergenerator() {
    var randomVerse = new Random();
    int number = randomVerse.nextInt(todayverse.length - 1);
    return number;
  }

  DateTime todaydate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return DateTime.parse(formattedDate);
  }

  void checktheinfo() async {
    List<Map<String, dynamic>> info =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    if (info.length > 0) {
      setState(() {
        onbording = false;
      });
    } else {
      await DatabaseHelper.instance.insert({
        DatabaseHelper.font: 18,
        DatabaseHelper.screenawak: 1,
        DatabaseHelper.blanguge: 'Nepali'
      }, DatabaseHelper.tableSetting);
    }
  }

  @override
  void initState() {
    super.initState(); //check sqlite data
    loadSetting();
    checktheinfo();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    showNotification('Today\'s Bible Verse',
        'Check out what God want to speak with you.', 0);

    new Timer(const Duration(milliseconds: 500), () {
      showNotification(
          'Nebible : Check our youtube channel',
          'Check out our new videos in youtube channel and listen word of God and stay  blessed.',
          1);
    });

    new Timer(const Duration(milliseconds: 1500), () {
      showNotification(
          'Support Nebible',
          'Now, you can support Nebible on esewa,khalti,imepay or in bank.\n You can start with Rs.100, your small effort make big change.\n Thank you.',
          2);
    });
  }

  Future onSelectNotification(String payload) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MainHomeScreen(
        payload: payload,
      );
    }));
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification(String title, String body, int id) async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(id, title, body, platform,
        payload: 'Welcome');
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: onbording ? Boarding() : MainHomeScreen(),
        title: new Text(
          'Welcome In Nebible',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        image: new Image.asset(
          'assets/images/logo.png',
        ),
        backgroundColor: kprimaryColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        onClick: () {},
        loaderColor: Colors.white);
  }
}
