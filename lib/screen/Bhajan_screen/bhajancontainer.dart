import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/data/balbhajan_data.dart';
import 'package:nebible/data/bhajan_data.dart';
import 'package:nebible/data/choros_data.dart';
import 'package:nebible/model/Bhajan.dart';
import 'package:nebible/screen/Bhajan_screen/bhajandetails.dart';
import 'package:toast/toast.dart';

class BhajanContainer extends StatefulWidget {
  @override
  _BhajanContainerState createState() => _BhajanContainerState();
}

int tabindex = 0;

class _BhajanContainerState extends State<BhajanContainer>
    with SingleTickerProviderStateMixin {
  //controller
  TabController _tabController;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  final TextEditingController _searchQuery = TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  String codeDialog;
  String valueText;

  List<Bhajangeet> bhajangeet = bhajansdata;
  List<Bhajangeet> chorosgeet = chorosdata;
  List<Bhajangeet> balgeet = balbhajandata;

  bool _isSearching;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          children: [
            Container(
              child: ListView(
                shrinkWrap: true,
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: _isSearching ? _buildSearchList() : _buildList(),
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: _isSearching ? _buildSearchList() : _buildList(),
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: _isSearching ? _buildSearchList() : _buildList(),
              ),
            ),
          ],
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  _BhajanContainerState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }
  List<ChildItem> _buildList() {
    if (tabindex == 0) {
      return bhajangeet
          .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
          .toList();
    } else if (tabindex == 1) {
      return chorosgeet
          .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
          .toList();
    } else {
      return balgeet
          .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
          .toList();
    }
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      if (tabindex == 0) {
        return bhajangeet
            .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
            .toList();
      } else if (tabindex == 1) {
        return chorosgeet
            .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
            .toList();
      } else {
        return balgeet
            .map((bhajan) => new ChildItem(bhajan.bhajannum, bhajan.title))
            .toList();
      }
    } else {
      List<String> _searchList = [];
      if (tabindex == 0) {
        for (int i = 0; i < bhajansdata.length; i++) {
          String name = bhajansdata[i].title;

          if (name.toLowerCase().contains(_searchText.toLowerCase())) {
            _searchList.add(name);
          }
        }
        return _searchList.map((bhajan) => new ChildItem('', bhajan)).toList();
      } else if (tabindex == 1) {
        for (int i = 0; i < chorosdata.length; i++) {
          String name = chorosdata[i].title;
          if (name.toLowerCase().contains(_searchText.toLowerCase())) {
            _searchList.add(name);
          }
        }
        return _searchList.map((choros) => new ChildItem('', choros)).toList();
      } else {
        for (int i = 0; i < balbhajandata.length; i++) {
          String name = balbhajandata[i].title;
          if (name.toLowerCase().contains(_searchText.toLowerCase())) {
            _searchList.add(name);
          }
        }
        return _searchList
            .map((balgeet) => new ChildItem('', balgeet))
            .toList();
      }
    }
  }

  Widget appBarTitle = Text(
    "Search",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = new TextField(
                  autofocus: true,
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.arrowCircleRight),
          color: Colors.white,
          onPressed: () {
            _displayTextInputDialog(context);
          },
        ),
      ],
      bottom: TabBar(
        onTap: (value) {
          setState(() {
            tabindex = value;
            _isSearching = false;
            _searchText = "";
          });
        },
        unselectedLabelColor: Colors.black,
        labelColor: Colors.white,
        tabs: [
          Tab(
            child: Text("Bhajan"),
          ),
          Tab(
            child: Text("Choros"),
          ),
          Tab(
            child: Text("BaalBhajan"),
          )
        ],
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      bottomOpacity: 1,
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Go To->'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Number"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Container(
                    color: Colors.red,
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Container(
                  color: kprimaryColor,
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                    if (tabindex == 0 &&
                        int.parse(codeDialog) >= 0 &&
                        int.parse(codeDialog) < balbhajandata.length) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BhajanDetails(
                              value: 'Bal',
                              index: int.parse(codeDialog),
                            ),
                          ));
                    } else if (tabindex == 1 &&
                        int.parse(codeDialog) >= 0 &&
                        int.parse(codeDialog) < chorosdata.length) {
                      //choros
                      // Bhajangeet bgeet = chorosdata[int.parse(codeDialog)];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BhajanDetails(
                              value: 'Cho', index: int.parse(codeDialog)),
                        ),
                      );
                    } else if (tabindex == 2 &&
                        int.parse(codeDialog) >= 0 &&
                        int.parse(codeDialog) < balbhajandata.length) {
                      //bal
                      //Bhajangeet bgeet = balbhajandata[int.parse(codeDialog)];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BhajanDetails(
                              value: 'Bha',
                              index: int.parse(codeDialog),
                            ),
                          ));
                    } else {
                      Toast.show("No Data Found!", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    }
                  });
                },
              ),
            ],
          );
        });
  }
}

class ChildItem extends StatelessWidget {
  final String bhajan;
  final String number;
  ChildItem(this.number, this.bhajan);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          //                    <-- BoxDecoration
          border: Border(bottom: BorderSide()),
        ),
        child: new ListTile(
            onTap: () {
              int a = 0;
              if (tabindex == 0) {
                for (int i = 0; i < bhajansdata.length; i++) {
                  if (this.bhajan == bhajansdata[i].title) {
                    a = i;
                    break;
                  }
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BhajanDetails(
                        value: 'Bal',
                        index: a,
                      ),
                    ));
              } else if (tabindex == 1) {
                for (int i = 0; i < chorosdata.length; i++) {
                  if (this.bhajan == chorosdata[i].title) {
                    a = i;
                    break;
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BhajanDetails(value: 'Cho', index: a),
                  ),
                );
              } else {
                for (int i = 0; i < balbhajandata.length; i++) {
                  if (this.bhajan == balbhajandata[i].title) {
                    a = i;
                    break;
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BhajanDetails(
                        value: 'Bha',
                        index: a,
                      ),
                    ));
              }
            },
            title: new Text('${this.number}  ${this.bhajan}')));
  }
}
