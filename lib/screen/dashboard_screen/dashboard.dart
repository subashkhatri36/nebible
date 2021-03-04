import 'package:admob_flutter/admob_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nebible/components/default.dart';
import 'package:nebible/components/drawer.dart';
import 'package:nebible/database/database_helper.dart';
import 'package:nebible/model/BibleChapterList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'component/sliderbanner.dart';
import 'component/todaybibleverse.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

String language = 'Nepali';

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchQuery = TextEditingController();
  List<BibleChapterlist> datasearch = [];

  String codeDialog;
  String valueText;
  bool _isSearching = false;
  String _searchText = "";

  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  double _fontsize;

  loadSetting() async {
    List<Map<String, dynamic>> qry =
        await DatabaseHelper.instance.queryAll(DatabaseHelper.tableSetting);
    setState(() {
      String f = qry[0]['${DatabaseHelper.font}'].toString();
      _fontsize = double.parse(f);
      language = qry[0]['${DatabaseHelper.blanguge}'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-5946802346170399/9038129455',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');

        interstitialAd.load();
      },
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        //showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        //showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        //showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        //showSnackBar('Admob $adType failed to load. :(');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dasboard'),
        elevation: 0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kprimaryColor,
          padding: EdgeInsets.symmetric(
              vertical: defaultpadding - 8, horizontal: defaultpadding - 5),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Todaybibleverse(fontsize: _fontsize, language: language),
              SizedBox(
                height: 10,
              ),
              SliderBanner(),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                height: 124,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          'Check Our Youtube Channel to get Spritual blessing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/banner.png',
                          fit: BoxFit.cover,
                          height: 50,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              const url =
                                  'https://www.youtube.com/channel/UCBhSHDqGrasCHsGgiSu1zAA?sub_confirmation=1';
                              //?sub_confirmation=1

                              //https://www.youtube.com/channel/UCR6XYgtIeLejScLep3DQ6nA?sub_confirmation=1
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Text(
                              'Visit Channel',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 124,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Check Our Other Youtube Channel.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          const url =
                              'https://www.youtube.com/channel/UCR6XYgtIeLejScLep3DQ6nA?sub_confirmation=1';
                          //?sub_confirmation=1

                          //https://www.youtube.com/channel/UCR6XYgtIeLejScLep3DQ6nA?sub_confirmation=1
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Visit Channel',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                        'Support Us to imporve Nebible App.\nYour Small Support encourage us to do big things'),
                    Image.asset(
                      'assets/images/support.png',
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'If you have any comment or feedback for this app then please let us know.\n lifechaningfellowship@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              AdmobBanner(
                adUnitId: 'ca-app-pub-5946802346170399/9038129455',
                adSize: bannerSize,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
                onBannerCreated: (AdmobBannerController controller) {
                  // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                  // Normally you don't need to worry about disposing this yourself, it's handled.
                  // If you need direct access to dispose, this is your guy!
                  // controller.dispose();
                },
              )
            ],
          ))),
      drawer: AppDrawer(),
    );
  }
}
