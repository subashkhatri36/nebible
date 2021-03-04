import 'package:flutter/material.dart';
import 'package:nebible/components/drawer.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/Bookmark.dart';

class Bookmarks extends StatefulWidget {
  static const String routeName = '/bookmark';

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List<BookmarkModel> bookmark = [];
  double _fontsize;

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableBookmark);
    List<Map<String, dynamic>> qry1 =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    setState(() {
      for (int i = 0; i < qry.length; i++) {
        bookmark.add(new BookmarkModel(
            description: qry[i]['${DatabaseHelper.description}'].toString()));
      }
      String f = qry1[0]['${DatabaseHelper.font}'].toString();
      _fontsize = double.parse(f);
      if (_fontsize == null) _fontsize = 18.0;
    });

    //_screenawak = qry[0]['${DatabaseHelper.screenawak}'];
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
        title: Text('Bookmarks'),
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: bookmark.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                child: ListTile(
                  isThreeLine: true,
                  title: Text(
                    'Bookmark ${index + 1}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: _fontsize),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        bookmark[index].description,
                        style: TextStyle(fontSize: _fontsize),
                        textAlign: TextAlign.justify,
                      ),
                      GestureDetector(
                          onTap: () async {
                            //delete this items from data base and update into list
                            await DatabaseHelper.instance
                                .detele(index, DatabaseHelper.tableBookmark);
                            removeItem(index);
                          },
                          child: Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            }),
      ),
      drawer: AppDrawer(),
    );
  }

  void removeItem(int index) {
    setState(() {
      bookmark = List.from(bookmark)..removeAt(index);
    });
  }
}
