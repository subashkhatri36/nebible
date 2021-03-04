import 'package:flutter/material.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:toast/toast.dart';

class Addprayer extends StatefulWidget {
  @override
  _AddprayerState createState() => _AddprayerState();
}

class _AddprayerState extends State<Addprayer> {
  String title = '';
  String description = '';

  List<String> plisttype = [
    'Once',
    'Daily',
    'Morning',
    'Evening',
    'Monthly',
    'Yearly'
  ];
  String _prayer = '';
  String _category = '';
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownCategoryItems;

  List<String> plistCategory = [
    'Family',
    'Friend',
    'Husband',
    'Wife',
    'Kids',
    'Parents',
    'Fellowship',
    'Yearly Goal',
    'Jobs'
  ];
  TextEditingController editingController = new TextEditingController();
  TextEditingController editingController1 = new TextEditingController();
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];

    for (String language in plisttype) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: language,
          child: new Text(
            language,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownCategoryItems() {
    List<DropdownMenuItem<String>> items = [];

    for (String language in plistCategory) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: language,
          child: new Text(
            language,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _dropDownCategoryItems = getDropDownCategoryItems();
    setState(() {
      _prayer = _dropDownMenuItems[0].value;
      _category = _dropDownCategoryItems[0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Prayer'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            TextField(
              maxLength: 30,
              scrollPadding: EdgeInsets.all(10),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              controller: editingController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: TextField(
                maxLines: 100,
                maxLength: 200,
                scrollPadding: EdgeInsets.all(10),
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                controller: editingController1,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Prayer Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 110,
                  child: DropdownButton(
                    value: _prayer,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  value: _category,
                  items: _dropDownCategoryItems,
                  onChanged: changeDropDownCategoryItem,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                saveData();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Save Prayer',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void saveData() async {
    if (title.isNotEmpty && description.isNotEmpty) {
      int sav = await DatabaseHelper.instance.insert({
        DatabaseHelper.title: title,
        DatabaseHelper.description: description,
        DatabaseHelper.ptype: _prayer,
        DatabaseHelper.pcategory: _category
      }, DatabaseHelper.tablePrayer);

      if (sav > 0) {
        Toast.show("Saved.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        Navigator.pop(context);
      } else {
        Toast.show("Not Saved .", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
    } else {
      Toast.show("Please fill title and description .", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

  void changedDropDownItem(String selectedprayer) {
    setState(() {
      _prayer = selectedprayer;

      // updatelanguage();
      // loadbookname();
    });
  }

  void changeDropDownCategoryItem(String selectedprayer) {
    setState(() {
      _category = selectedprayer;
    });
  }
}
