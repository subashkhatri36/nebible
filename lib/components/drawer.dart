import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebible/components/Routes.dart';
import 'package:nebible/components/default.dart';
import 'package:nebible/screen/dialog/customdialog.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];
  onDeleteImage(int position) async {
    setState(() {
      imagePaths.removeAt(position);
    });
  }

  onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.dashboard);
              }),
          _createDrawerItem(
              icon: FontAwesomeIcons.stickyNote,
              text: 'Biswasi ko sar',
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.believer);
              }),
          _createDrawerItem(
              icon: Icons.bookmark,
              text: 'Bookmarks',
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.bookmark);
              }),
          _createDrawerItem(
            icon: FontAwesomeIcons.guitar,
            text: 'Guitar Chords',
            onTap: () {},
          ),
          Divider(),
          _createDrawerItem(
              onTap: () {
                like();
              },
              icon: Icons.thumb_up,
              text: 'Like'),
          _createDrawerItem(
              onTap: () {
                Share.share(
                    'Download Nebible App from below link \n https://www.facebook.com/Nebible',
                    subject: 'Download Nebible App');
              },
              icon: Icons.share,
              text: 'Share'),
          _createDrawerItem(icon: Icons.stars, text: 'Rate'),
          Divider(),
          _createDrawerItem(
              icon: Icons.report,
              text: 'Disclaimer',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        title: "Disclaimer",
                        descriptions:
                            "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                        text: "Ok",
                      );
                    });
              }),
          _createDrawerItem(
              icon: Icons.info,
              text: 'About Us',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        title: "About Us",
                        descriptions:
                            "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                        text: "Ok",
                      );
                    });
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Setting',
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.setting);
              }),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

void like() async {
  const url = 'https://www.facebook.com/Nebible';
  //?sub_confirmation=1

  //https://www.youtube.com/channel/UCR6XYgtIeLejScLep3DQ6nA?sub_confirmation=1
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: kprimaryColor,
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/logo.png'))),
      child: Text(''));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
