import 'package:flutter/material.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/prayermodel.dart';
import 'package:nebible/screen/pray_screen/add_prayer.dart';
import 'package:wakelock/wakelock.dart';

class Pray extends StatefulWidget {
  @override
  _PrayState createState() => _PrayState();
}

class _PrayState extends State<Pray> {
  int _screenawak;
  List<Prayerlist> prayers = [];

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    _screenawak = qry[0]['${DatabaseHelper.screenawak}'];

    if (_screenawak == 1) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  loadprayer() async {
    if (prayers.length > 0) prayers.clear();
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tablePrayer);
    setState(() {
      for (int i = 0; i < qry.length; i++) {
        prayers.add(Prayerlist(
          prayertitle: qry[i]['${DatabaseHelper.title}'],
          prayerdescription: qry[i]['${DatabaseHelper.description}'],
          prayertype: qry[i]['${DatabaseHelper.ptype}'],
          prayerstatus: qry[i]['${DatabaseHelper.pcategory}'],
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
    loadprayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer List'),
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
              itemCount: prayers.length,
              itemBuilder: (BuildContext context, int index) {
                Prayerlist listofpray = prayers[index];
                return index % 2 == 0
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border(bottom: BorderSide()),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listofpray.prayertitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${listofpray.prayertype}/${listofpray.prayerstatus}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          DatabaseHelper.instance.detele(index,
                                              DatabaseHelper.tablePrayer);
                                          removeItem(index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text(
                              listofpray.prayerdescription,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide()),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listofpray.prayertitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${listofpray.prayertype}/${listofpray.prayerstatus}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          DatabaseHelper.instance.detele(index,
                                              DatabaseHelper.tablePrayer);
                                          removeItem(index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text(
                              listofpray.prayerdescription,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ));
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Addprayer()));
                loadprayer();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void removeItem(int index) {
    setState(() {
      prayers = List.from(prayers)..removeAt(index);
    });
  }
}
