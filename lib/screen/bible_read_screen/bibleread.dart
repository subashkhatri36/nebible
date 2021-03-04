import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/BibleChapterList.dart';
import 'package:nebible/model/BibleVerse.dart';
import 'package:nebible/screen/bible_read_screen/intro_screen.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:wakelock/wakelock.dart';

class BibleRead extends StatefulWidget {
  @override
  _BibleReadState createState() => _BibleReadState();
}

class _BibleReadState extends State<BibleRead> {
  List<bool> selectedList = [];

  String biblebook = '';
  String biblechapter = '';
  String bibleverse = '';
  // String description = '';

  List<BibleVerse> bvlist = [];
  int currentbook;

  List _language = ["Nepali", "English", "Both"];
  List<String> booklist = [];
  List<String> chapterlist = [];
  List<String> verselist = [];

  double _fontsize;
  int _screenawak;

  int verseposition;
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List<BibleVerse> bibleversenumber(String bookname, String chpnum) {
    List<BibleVerse> b = [];
    for (int i = 0; i < books.length; i++) {
      if (bookname == books[i].chapterNepaliName ||
          bookname == books[i].chapterEnglishName ||
          bookname ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        currentbook = i;
        for (int j = 0; j < books[i].totalChapter; j++) {
          if (chpnum == books[i].chapters[j].chapter) {
            b = books[i].chapters[j].verse;
            break;
          }
        }
      }
    }
    return b;
  }

  //Jesus speaking text
  void jesusspeakcolor(int start, int end) {}
  // state variable
  String _radiolanguageValue = '';
  @override
  void initState() {
    super.initState();
    loadpre();
    loadSetting();
    getdatafromdatabase();
    loadchapter();
    _dropDownMenuItems = getDropDownMenuItems();

    setState(() {
      for (int i = 0; i < _language.length; i++) {
        if (_radiolanguageValue.isNotEmpty &&
            _dropDownMenuItems[i].value == _radiolanguageValue) {
          _radiolanguageValue = _dropDownMenuItems[i].value;
          break;
        } else {
          _radiolanguageValue = _dropDownMenuItems[0].value;
        }
      }
    });
    bvlist = bibleversenumber(biblebook, biblechapter);
    listselectionfalse();
  }

  listselectionfalse() {
    if (selectedList.length > 0) selectedList.clear();
    setState(() {
      for (int i = 0; i < bvlist.length; i++) {
        selectedList.add(false);
      }
    });
  }

  bool islistSelected() {
    bool sel = false;
    setState(() {
      for (int i = 0; i < bvlist.length; i++) {
        if (selectedList[i]) {
          sel = true;
          break;
        }
      }
    });
    return sel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              changeprechapter();
              update();
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white),
                    top: BorderSide(color: Colors.white),
                    left: BorderSide(color: Colors.white),
                    right: BorderSide(color: Colors.white)),
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              _displayBookDialog(context);
              update();
            },
            child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                width: 160,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white)),
                ),
                child: Text(
                  biblebook,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              _displayChapterDialog(context);
              update();
            },
            child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                width: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white)),
                ),
                child: Text(
                  biblechapter,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              changenextchapter();
              update();
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white),
                    top: BorderSide(color: Colors.white),
                    left: BorderSide(color: Colors.white),
                    right: BorderSide(color: Colors.white)),
              ),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: kprimaryColor,
        child: Stack(
          children: [
            languageContainer(context),
            DraggableScrollableSheet(
              builder: (contex, scrollController) {
                return Container(
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _radiolanguageValue == 'Nepali'
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedList[index]) {
                                    selectedList[index] = false;
                                  } else {
                                    selectedList[index] = true;
                                  }
                                });
                              },
                              child: Container(
                                  decoration: selectedList[index]
                                      ? new BoxDecoration(
                                          color: Colors.grey[300])
                                      : new BoxDecoration(),
                                  //only for nepali
                                  child: bvlist[index].title.isNotEmpty
                                      ? ListTile(
                                          //required title
                                          title: Text(
                                            bvlist[index].title,
                                            style: TextStyle(
                                                fontSize: _fontsize,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          isThreeLine: true,
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${bvlist[index].verse} ${bvlist[index].nepverse}',
                                                style: TextStyle(
                                                    fontSize: _fontsize),
                                                textAlign: TextAlign.justify,
                                              ),
                                              if (bvlist[index]
                                                  .relateverse
                                                  .isNotEmpty)
                                                IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.comment,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    _displayInfoDialog(
                                                        context,
                                                        bvlist[index]
                                                            .relateverse);
                                                  },
                                                )
                                            ],
                                          ))
                                      : ListTile(
                                          isThreeLine: true,
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${bvlist[index].verse} ${bvlist[index].nepverse}',
                                                style: TextStyle(
                                                    fontSize: _fontsize),
                                                textAlign: TextAlign.justify,
                                              ),
                                              if (bvlist[index]
                                                  .relateverse
                                                  .isNotEmpty)
                                                IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.comment,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    _displayInfoDialog(
                                                        context,
                                                        bvlist[index]
                                                            .relateverse);
                                                  },
                                                )
                                            ],
                                          )
                                          //no title
                                          )),
                            )
                          : _radiolanguageValue == 'English'
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedList[index]) {
                                        selectedList[index] = false;
                                      } else {
                                        selectedList[index] = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: selectedList[index]
                                        ? new BoxDecoration(
                                            color: Colors.grey[300])
                                        : new BoxDecoration(),
                                    child: bvlist[index].title.isNotEmpty
                                        ? ListTile(
                                            //required title
                                            isThreeLine: true,
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${bvlist[index].verse} ${bvlist[index].englishverse}',
                                                  style: TextStyle(
                                                      fontSize: _fontsize),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                if (bvlist[index]
                                                    .relateverse
                                                    .isNotEmpty)
                                                  IconButton(
                                                    icon: Icon(
                                                      FontAwesomeIcons.comment,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _displayInfoDialog(
                                                          context,
                                                          bvlist[index]
                                                              .relateverse);
                                                    },
                                                  )
                                              ],
                                            ))
                                        : ListTile(
                                            subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${bvlist[index].verse} ${bvlist[index].englishverse}',
                                                style: TextStyle(
                                                    fontSize: _fontsize),
                                                textAlign: TextAlign.justify,
                                              ),
                                              if (bvlist[index]
                                                  .relateverse
                                                  .isNotEmpty)
                                                IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.comment,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    _displayInfoDialog(
                                                        context,
                                                        bvlist[index]
                                                            .relateverse);
                                                  },
                                                )
                                            ],
                                          )),
                                    //only for english
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedList[index]) {
                                        selectedList[index] = false;
                                      } else {
                                        selectedList[index] = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: selectedList[index]
                                        ? new BoxDecoration(
                                            color: Colors.grey[300])
                                        : new BoxDecoration(),
                                    child: bvlist[index].title.isNotEmpty
                                        ? ListTile(
                                            //required title
                                            isThreeLine: true,
                                            title: Text(
                                              '${bvlist[index].title}',
                                              style: TextStyle(
                                                  fontSize: _fontsize,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${bvlist[index].verse} ${bvlist[index].nepverse}',
                                                  style: TextStyle(
                                                      fontSize: _fontsize),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Text(
                                                  ' ${bvlist[index].englishverse}',
                                                  style: TextStyle(
                                                      fontSize: _fontsize),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                if (bvlist[index]
                                                    .relateverse
                                                    .isNotEmpty)
                                                  IconButton(
                                                    icon: Icon(FontAwesomeIcons
                                                        .comment),
                                                    onPressed: () {
                                                      _displayInfoDialog(
                                                          context,
                                                          bvlist[index]
                                                              .relateverse);
                                                    },
                                                  )
                                              ],
                                            ))
                                        : ListTile(
                                            subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${bvlist[index].verse} ${bvlist[index].nepverse}',
                                                style: TextStyle(
                                                    fontSize: _fontsize),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Text(
                                                '${bvlist[index].englishverse}',
                                                style: TextStyle(
                                                    fontSize: _fontsize),
                                                textAlign: TextAlign.justify,
                                              ),
                                              if (bvlist[index]
                                                  .relateverse
                                                  .isNotEmpty)
                                                IconButton(
                                                  icon: Icon(
                                                      FontAwesomeIcons.comment),
                                                  onPressed: () {
                                                    _displayInfoDialog(
                                                        context,
                                                        bvlist[index]
                                                            .relateverse);
                                                  },
                                                )
                                            ],
                                          )),
                                    //for both
                                  ),
                                );
                    },
                    shrinkWrap: true,
                    itemCount: bvlist.length,
                    //controller: ScrollController(keepScrollOffset: false),
                  ),
                );
              },
              initialChildSize: 0.92,
              minChildSize: 0.92,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }

  void changeprechapter() {
    int chap = 0;
    for (int i = 0; i < books.length; i++) {
      if (biblebook == books[i].chapterNepaliName ||
          biblebook == books[i].chapterEnglishName ||
          biblebook ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        int c = int.parse(biblechapter);
        if (c == 1) {
          //changing book
          if (i > 0) {
            setState(() {
              _radiolanguageValue == 'Nepali'
                  ? biblebook = books[i].chapterNepaliName
                  : _radiolanguageValue == 'English'
                      ? biblebook = books[i].chapterNepaliName
                      : biblebook =
                          '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}';

              for (int a = 0; a < books.length; a++) {
                if (biblebook == books[a].chapterNepaliName ||
                    biblebook == books[a].chapterEnglishName ||
                    biblebook ==
                        '${books[a].chapterNepaliName} ${books[a].chapterEnglishName}') {
                  chap = books[a].totalChapter - 1;
                  biblechapter = chap.toString();
                  break;
                }
              }
            });
            break;
          }
        } else {
          setState(() {
            chap = int.parse(biblechapter) - 1;
            biblechapter = chap.toString();
          });
          break;
        }
      }
    }
    bvlist = bibleversenumber(biblebook, biblechapter);
  }

  void changenextchapter() {
    int chap = 0;
    for (int i = 0; i < books.length; i++) {
      if (biblebook == books[i].chapterNepaliName ||
          biblebook == books[i].chapterEnglishName ||
          biblebook ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        int c = int.parse(biblechapter);
        if (c == books[i].totalChapter - 1) {
          //changing book
          if (i < books.length - 1) {
            int a = i;

            setState(() {
              a++;
              _radiolanguageValue == 'Nepali'
                  ? biblebook = books[a].chapterNepaliName
                  : _radiolanguageValue == 'English'
                      ? biblebook = books[a].chapterNepaliName
                      : biblebook =
                          '${books[a].chapterNepaliName} ${books[a].chapterEnglishName}';
              chap = 1;
              biblechapter = chap.toString();
            });
            break;
          }
        } else {
          setState(() {
            if (c < books[i].totalChapter - 1) {
              chap = int.parse(biblechapter) + 1;
              biblechapter = chap.toString();
            }
          });
          break;
        }
      }
    }
    bvlist = bibleversenumber(biblebook, chap.toString());
  }

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    setState(() {
      String f = qry[0]['${DatabaseHelper.font}'].toString();
      _fontsize = double.parse(f);

      if (_fontsize == null) _fontsize = 18.0;
      _screenawak = qry[0]['${DatabaseHelper.screenawak}'];

      _radiolanguageValue = qry[0]['${DatabaseHelper.blanguge}'].toString();
      loadbookname();
    });

    if (_screenawak == 1) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  void loadchapter() {
    if (chapterlist.length > 0) chapterlist.clear();

    for (int i = 0; i < books.length; i++) {
      if (biblebook == books[i].chapterNepaliName ||
          biblebook == books[i].chapterEnglishName ||
          biblebook ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        for (int j = 1; j <= books[i].totalChapter; j++) {
          chapterlist.add(j.toString());
        }
        biblechapter = chapterlist[0];
        loadVerse(biblebook, biblechapter);
        break;
      }
    }
  }

  void loadbookname() {
    booklist.clear();
    for (int i = 0; i < books.length; i++) {
      _radiolanguageValue == 'Nepali'
          ? booklist.add(books[i].chapterNepaliName)
          : _radiolanguageValue == 'English'
              ? booklist.add(books[i].chapterEnglishName)
              : booklist.add(
                  '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}');
    }
  }

// here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];

    for (String language in _language) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: language,
          child: new Text(
            language,
            style: TextStyle(color: Colors.white),
          )));
    }
    return items;
  }

  void loadpre() {
    setState(() {
      if (biblebook.isEmpty) biblebook = 'उत्पत्ति';
      if (biblechapter.isEmpty) biblechapter = '1';
      if (bibleverse.isEmpty) bibleverse = '1';
    });
  }

  getdatafromdatabase() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableBook);
    setState(() {
      biblebook = qry[0]['${DatabaseHelper.bname}'].toString();
      biblechapter = qry[0]['${DatabaseHelper.bchapter}'].toString();
      bibleverse = qry[0]['${DatabaseHelper.bverse}'].toString();

      for (int i = 0; i < books.length; i++) {
        if (biblebook == books[i].chapterEnglishName ||
            biblebook == books[i].chapterNepaliName ||
            biblebook ==
                '${biblebook == books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
          if (_radiolanguageValue == 'Nepali') {
            biblebook = books[i].chapterNepaliName;
          } else if (_radiolanguageValue == 'English') {
            biblebook = books[i].chapterEnglishName;
          } else
            biblebook =
                '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}';
        }
      }
    });
  }

  update() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableBook);
    if (qry.length > 0) {
      DatabaseHelper.instance.update({
        DatabaseHelper.bname: biblebook,
        DatabaseHelper.bchapter: biblechapter,
        DatabaseHelper.bverse: bibleverse
      }, DatabaseHelper.tableBook, 1);
    } else {
      DatabaseHelper.instance.insert({
        DatabaseHelper.bname: biblebook,
        DatabaseHelper.bchapter: biblechapter,
        DatabaseHelper.bverse: bibleverse
      }, DatabaseHelper.tableBook);
    }

    listselectionfalse();
  }

  insertbookmark() async {
    String v = shareSelection();
    if (v.isNotEmpty) {
      int mark = await DatabaseHelper.instance.insert({
        DatabaseHelper.bname: biblebook,
        DatabaseHelper.bchapter: biblechapter,
        DatabaseHelper.bverse: bibleverse,
        DatabaseHelper.description: v
      }, DatabaseHelper.tableBookmark);
      if (mark == 1) {
        Toast.show("Bookmark Saved.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
    }
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _radiolanguageValue = selectedCity;
      for (int i = 0; i < books.length; i++) {
        if (biblebook == books[i].chapterNepaliName ||
            biblebook == books[i].chapterEnglishName) {
          _radiolanguageValue == 'Nepali'
              ? biblebook = books[i].chapterNepaliName
              : _radiolanguageValue == 'English'
                  ? biblebook = books[i].chapterEnglishName
                  : biblebook =
                      '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}';
        }
      }
      updatelanguage();
      loadbookname();
    });
  }

  void updatelanguage() async {
    await DatabaseHelper.instance.update(
        {DatabaseHelper.blanguge: _radiolanguageValue},
        DatabaseHelper.tableSetting,
        1);
  }

  Container languageContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Language',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          dropdownColor: kprimaryColor,
                          value: _radiolanguageValue,
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
                        ),
                      ],
                    ),

                    //check selection
                    islistSelected()
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                GestureDetector(
                                  onTap: () {
                                    String a = shareSelection();
                                    Clipboard.setData(new ClipboardData(
                                        text: a +
                                            '\n' +
                                            'Download Nebible App from below link \n https://www.facebook.com/Nebible'));
                                    listselectionfalse();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    insertbookmark();
                                    listselectionfalse();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String a = shareSelection();
                                    Share.share(
                                        a +
                                            '\n' +
                                            'Download Nebible App from below link \n https://www.facebook.com/Nebible',
                                        subject: 'Read Bible Verse');
                                    listselectionfalse();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ])
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterIntro(
                                            value: currentbook,
                                            check: _radiolanguageValue,
                                          )));
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ])),
        ],
      ),
    );
  }

  String shareSelection() {
    String shareContent = '';
    String verseContent = '';
    int chap = int.parse(biblechapter) - 1;
    String allConent = '';
    for (int i = 0; i < books.length; i++) {
      if (biblebook == books[i].chapterEnglishName ||
          biblebook == books[i].chapterNepaliName ||
          biblebook ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        for (int a = 0; a < books[i].chapters[chap].verse.length; a++) {
          int v = a;
          if (selectedList[a]) {
            setState(() {
              verseContent = verseContent + (v + 1).toString() + ', ';

              if (_radiolanguageValue == 'English') {
                shareContent = shareContent +
                    books[i].chapters[chap].verse[a].verse +
                    ' ' +
                    books[i].chapters[chap].verse[a].englishverse;
              } else {
                shareContent = shareContent +
                    books[i].chapters[chap].verse[a].verse +
                    ' ' +
                    books[i].chapters[chap].verse[a].nepverse;
              }
            });
          }
        }
        break;
      }
    }

    allConent = biblebook + ' ' + biblechapter + ': ' + shareContent;

    return allConent;
  }

  Future<void> _displayInfoDialog(
      BuildContext context, String relateverse) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reference'),
            content: Text(relateverse),
            actions: <Widget>[
              ElevatedButton(
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayBookDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Books'),
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
                          itemCount: booklist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                title: Text(booklist[index]),
                                value: index,
                                groupValue: biblebook,
                                onChanged: (value) {
                                  setState(() {
                                    biblebook = booklist[index];
                                    loadchapter();
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

  Future<void> _displayChapterDialog(BuildContext context) async {
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
                          itemCount: chapterlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                title: Text(chapterlist[index]),
                                value: index,
                                groupValue: biblechapter,
                                onChanged: (value) {
                                  setState(() {
                                    biblechapter = chapterlist[index];
                                    loadVerse(biblebook, biblechapter);
                                    update();
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

  void loadVerse(String bookname, String chapterNumber) {
    verselist.clear();
    for (int i = 0; i < books.length; i++) {
      if (biblebook == books[i].chapterNepaliName ||
          biblebook == books[i].chapterEnglishName ||
          biblebook ==
              '${books[i].chapterNepaliName} ${books[i].chapterEnglishName}') {
        for (int j = 1; j <= books[i].totalChapter; j++) {
          if (chapterNumber == j.toString()) {
            for (int a = 1; a < books[i].chapters[j - 1].verse.length; a++) {
              verselist.add(a.toString());
            }
            break;
          }
        }
        // bibleverse = verselist[0];
        verseposition = 0;
      }
    }

    bvlist = bibleversenumber(biblebook, chapterNumber);
  }
}
