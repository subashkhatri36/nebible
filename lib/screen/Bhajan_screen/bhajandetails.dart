import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/data/balbhajan_data.dart';
import 'package:nebible/data/bhajan_data.dart';
import 'package:nebible/data/choros_data.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/Bhajan.dart';

// ignore: must_be_immutable
class BhajanDetails extends StatefulWidget {
  String value;
  int index;

  BhajanDetails({Key key, @required this.value, this.index}) : super(key: key);

  @override
  _BhajanDetailsState createState() => _BhajanDetailsState();
}

class _BhajanDetailsState extends State<BhajanDetails> {
  bool chords = true;
  List<String> bname;
  List<String> cname;
  List<Bhajangeet> geet;
  double _fontsize;
  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    setState(() {
      String f = qry[0]['${DatabaseHelper.font}'].toString();

      _fontsize = double.parse(f);
      if (_fontsize == null) _fontsize = 18.0;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value == 'Bal') {
      geet = bhajansdata;
      bname = geet[widget.index].bhajan;
      cname = geet[widget.index].chordbhajan;
    } else if (widget.value == 'Cho') {
      geet = chorosdata;
      bname = geet[widget.index].bhajan;
      cname = geet[widget.index].chordbhajan;
    } else {
      geet = balbhajandata;
      bname = geet[widget.index].bhajan;
      cname = geet[widget.index].chordbhajan;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(geet[widget.index].bhajannum),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: kprimaryColor,
                  value: this.chords,
                  onChanged: (bool value) {
                    setState(() {
                      this.chords = value;
                    });
                  },
                ),
                Text(
                  'Chord',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                geet[widget.index].link != ''
                    ? Icon(FontAwesomeIcons.play)
                    : SizedBox(width: 1),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 10, bottom: 15, left: 5, right: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.index > 0) {
                            widget.index--;
                          }
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                      )),
                  Column(
                    children: [
                      Text(
                        geet[widget.index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        geet[widget.index].tal,
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.index < geet.length - 1) {
                            widget.index++;
                          }
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bname.length,
                  itemBuilder: (BuildContext context, int index) {
                    return chords
                        ? Container(
                            color: index % 2 == 0
                                ? Colors.grey[300]
                                : Colors.white,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              cname[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: _fontsize),
                            ),
                          )
                        : Container(
                            color: index % 2 == 0
                                ? Colors.grey[300]
                                : Colors.white,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              bname[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: _fontsize),
                            ),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
