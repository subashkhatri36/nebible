import 'package:flutter/material.dart';
import 'package:nebible/screen/main_home_screen/mainhomescreen.dart';
import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class Boarding extends StatelessWidget {
  final pages = [
    SkOnboardingModel(
        title: 'Two Verson Bible',
        description:
            'Two Version bible from Nepal Bible Society (NNRV) and English (Kjv).',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/nebible.png'),
    SkOnboardingModel(
        title: 'Bhajan With Chords',
        description:
            'You can have bhajan and chord, you can play your favourite christian songs.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/chords.png'),
    SkOnboardingModel(
        title: 'Easy To Use',
        description:
            'Pray, Search, Bookmarks, and get daily bible verse and its all easy to use.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/bible.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: const Color(0xFFf74269),
        pages: pages,
        skipClicked: (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeScreen(),
            ),
            (route) => false,
          );
        },
        getStartedClicked: (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeScreen(),
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}
//-------------Other properties--------------
//background,
//pagesContentPadding,
//pagesImageColor,
//titleAndInfoPadding,
//titleAndInfoHeight,
//titleStyle,
//infoStyle,
//infoPadding,
//footerPadding,
//skipButtonStyle,
