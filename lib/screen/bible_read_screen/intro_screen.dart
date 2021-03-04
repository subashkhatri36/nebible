import 'package:flutter/material.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/BibleChapterList.dart';
import 'package:wakelock/wakelock.dart';

class ChapterIntro extends StatefulWidget {
  final int value;
  final String check;

  const ChapterIntro({Key key, this.value, this.check}) : super(key: key);

  @override
  _ChapterIntroState createState() => _ChapterIntroState();
}

class _ChapterIntroState extends State<ChapterIntro> {
  double _fontsize;
  int _screenawak;
  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);

    _fontsize = qry[0]['${DatabaseHelper.font}'];
    _screenawak = qry[0]['${DatabaseHelper.screenawak}'];
    if (_screenawak == 1) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
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
        title: Text(books[widget.value].chapterNepaliName),
        backgroundColor: kprimaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Introduction',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'General Information',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Author : ${books[widget.value].autherName}',
                style: TextStyle(
                  fontSize: _fontsize,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.check == 'Nepali'
                      ? Text(
                          'Book \n ${books[widget.value].chapterNepaliName}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : widget.check == 'English'
                          ? Text(
                              'Book \n ${books[widget.value].chapterEnglishName}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'Book \n ${books[widget.value].chapterEnglishName},${books[widget.value].chapterNepaliName}\n',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                  Text(
                    'Chapter \n ${books[widget.value].totalChapter}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Verses \n ${books[widget.value].totalVerse}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Words \n ${books[widget.value].totalWords}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              widget.check == 'Nepali'
                  ? Text(
                      '${books[widget.value].nepaliIntro}',
                      style: TextStyle(
                        fontSize: _fontsize,
                      ),
                      textAlign: TextAlign.justify,
                    )
                  : widget.check == 'English'
                      ? Text(
                          '${books[widget.value].englishIntro}',
                          style: TextStyle(
                            fontSize: _fontsize,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      : Text(
                          '${books[widget.value].nepaliIntro} \n\n${books[widget.value].englishIntro}',
                          style: TextStyle(
                            fontSize: _fontsize,
                          ),
                          textAlign: TextAlign.justify,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
