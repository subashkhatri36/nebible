import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/data/TodayVerse.dart';
import 'package:nebible/database/database_helper.dart';
//https://drive.google.com/file/d/1TCkPYBJWUne5MrMO-eZJFe8MhyFSnJ7Y/view?usp=sharing

class Todaybibleverse extends StatefulWidget {
  final double fontsize;
  final String language;
  const Todaybibleverse({Key key, this.fontsize, this.language})
      : super(key: key);

  @override
  _TodaybibleverseState createState() => _TodaybibleverseState();
}

class _TodaybibleverseState extends State<Todaybibleverse> {
  int randomnumbergenerator() {
    var randomVerse = new Random();
    int number = randomVerse.nextInt(todayverse.length);
    if (number >= todayverse.length) number = 0;
    return number;
  }

  DateTime todaydate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return DateTime.parse(formattedDate);
  }

  String gettodaydate;
  int getnumber = -1;

  void checkdatabase() async {
    List<Map<String, dynamic>> info =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableTodayVerse);

    if (info.length > 0) {
      //there is already data
      //check the date if differ or not
      List<Map<String, dynamic>> qry = await DatabaseHelper.instance
          .queryAll(DatabaseHelper.tableTodayVerse);
      getnumber = qry[0]['${DatabaseHelper.bverse}'];
      gettodaydate = qry[0]['${DatabaseHelper.today}'];
      DateTime getDate = DateTime.parse(gettodaydate);
      if (todaydate() != getDate) {
        //date matched
        //notmatched
        //update date and verse and
        getnumber = randomnumbergenerator();
        await DatabaseHelper.instance.update({
          DatabaseHelper.bverse: randomnumbergenerator(),
          DatabaseHelper.today: todaydate().toString()
        }, DatabaseHelper.tableTodayVerse, 1);
      } //get the data if date is same its ok not update database

    } else {
      //there is no data
      //write data
      getnumber = randomnumbergenerator();
      await DatabaseHelper.instance.insert({
        DatabaseHelper.bverse: randomnumbergenerator(),
        DatabaseHelper.today: todaydate().toString()
      }, DatabaseHelper.tableTodayVerse);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getnumber = randomnumbergenerator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bible Verse of the Day',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 14),
              ),
              GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(
                      text: getverse(),
                    ));
                  },
                  child: Icon(Icons.share))
            ],
          ),
          SizedBox(
            height: defaultpadding / 2,
          ),
          Text(
            getverse(),
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  String getverse() {
    checkdatabase();
    String v = '';
    String bookname = todayverse[getnumber].book;
    String nbook = todayverse[getnumber].nbook;
    int chapter = todayverse[getnumber].chapter;
    int fromverse = todayverse[getnumber].fromverse;
    int toverse = todayverse[getnumber].toverse;
    String english = todayverse[getnumber].engverse;
    String nepali = todayverse[getnumber].nepverse;
    if (widget.language == 'English') {
      if (toverse > 0) {
        v = bookname +
            ' ' +
            chapter.toString() +
            " : " +
            fromverse.toString() +
            '-' +
            toverse.toString() +
            " " +
            english;
      } else {
        v = bookname +
            ' ' +
            chapter.toString() +
            " : " +
            fromverse.toString() +
            " " +
            english;
      }
    } else {
      if (toverse > 0) {
        v = nbook +
            ' ' +
            chapter.toString() +
            " : " +
            fromverse.toString() +
            '-' +
            toverse.toString() +
            " " +
            nepali;
      } else {
        v = nbook +
            ' ' +
            chapter.toString() +
            " : " +
            fromverse.toString() +
            " " +
            nepali;
      }
    }

    return v;
  }
}
