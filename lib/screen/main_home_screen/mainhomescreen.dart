import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/screen/Bhajan_screen/bhajancontainer.dart';
import 'package:nebible/screen/bible_read_screen/bibleread.dart';
import 'package:nebible/screen/dashboard_screen/dashboard.dart';
import 'package:nebible/screen/pray_screen/pray.dart';
import 'package:rate_my_app/rate_my_app.dart';

class MainHomeScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  final String payload;

  const MainHomeScreen({Key key, this.payload}) : super(key: key);
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  double fontsize;
  int screenawak;

  var screens = [
    Dashboard(),
    BibleRead(),
    BhajanContainer(),
    Pray()
  ]; //sceen for each tabls
  int selectedTab = 0;

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an nebible'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: roundedButton("No", kprimaryColor, Colors.white),
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: roundedButton(" Yes ", kprimaryColor, Colors.white),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0, // Show rate popup on first day of install.
    minLaunches:
        5, // Show rate popup after 5 launches of app after minDays is passed.
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1491556149',
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: kprimaryColor,
          unselectedItemColor: Colors.black87,
          currentIndex: selectedTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bible), label: 'Bible'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.book), label: 'Bhajan'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.pray), label: 'Pray'),
          ],
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          showUnselectedLabels: true,
          iconSize: 20,
        ),
        body: screens[selectedTab],
      ),
    );
  }
}
