import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/drawer.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:toast/toast.dart';
import 'package:wakelock/wakelock.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/setting';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _fontsize = 14;
  bool isSwitched = true;
  String language = 'Nepali';
  int _screenawak;

  List _language = ["Nepali", "English", "Both"];

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);

    setState(() {
      String f = qry[0]['${DatabaseHelper.font}'].toString();
      language = qry[0]['${DatabaseHelper.blanguge}'].toString();

      _fontsize = double.parse(f);

      if (_fontsize == null) _fontsize = 18.0;
      _screenawak = qry[0]['${DatabaseHelper.screenawak}'];
    });

    if (_screenawak == 1) {
      isSwitched = true;
      Wakelock.enable();
    } else {
      isSwitched = false;
      Wakelock.disable();
    }
  }

  void updateData() async {
    int updated = await DatabaseHelper.instance.update({
      DatabaseHelper.font: _fontsize,
      DatabaseHelper.blanguge: language,
      DatabaseHelper.screenawak: isSwitched ? 1 : 0
    }, DatabaseHelper.tableSetting, 1);
    if (updated == 1) {
      Toast.show("Updated !", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            //screen awake
            Container(
              decoration: BoxDecoration(
                //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Screen Awake',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        updateData();
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //language

            Container(
              decoration: BoxDecoration(
                //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.globe),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _displaylanguageDialog(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Language',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '$language',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //font
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  Text('Font Size',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Font Height',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: _fontsize)),
                  SizedBox(
                    height: 10,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.red[700],
                      inactiveTrackColor: Colors.red[100],
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: Colors.redAccent,
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.red[700],
                      inactiveTickMarkColor: Colors.red[100],
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.redAccent,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      value: _fontsize,
                      min: 14,
                      max: 30,
                      divisions: 10,
                      label: '$_fontsize',
                      onChanged: (value) {
                        setState(
                          () {
                            _fontsize = value;
                            updateData();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }

  Future<void> _displaylanguageDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Chapter'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _language.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                title: Text(_language[index]),
                                value: index,
                                groupValue: language,
                                onChanged: (value) {
                                  setState(() {
                                    language = _language[index];
                                    updateData();
                                    Navigator.pop(context);
                                  });
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
