import 'dart:core';

import 'package:nebible/data/Acts.dart';
import 'package:nebible/data/Amos.dart';
import 'package:nebible/data/Chroniclesone.dart';
import 'package:nebible/data/Chroniclestwo.dart';
import 'package:nebible/data/Colossians.dart';
import 'package:nebible/data/Corinthiansone.dart';
import 'package:nebible/data/Corinthianstwo.dart';
import 'package:nebible/data/Daniel.dart';
import 'package:nebible/data/Deuteronomy.dart';
import 'package:nebible/data/Ecclesiastes.dart';
import 'package:nebible/data/Ephesians.dart';
import 'package:nebible/data/Esther.dart';
import 'package:nebible/data/Ezekiel.dart';
import 'package:nebible/data/Ezra.dart';
import 'package:nebible/data/Galatians.dart';
import 'package:nebible/data/Habakkuk.dart';
import 'package:nebible/data/Haggai.dart';
import 'package:nebible/data/Hebrews.dart';
import 'package:nebible/data/Hosea.dart';
import 'package:nebible/data/Isaiah.dart';
import 'package:nebible/data/James.dart';
import 'package:nebible/data/Jeremiah.dart';
import 'package:nebible/data/Joel.dart';
import 'package:nebible/data/John.dart';
import 'package:nebible/data/Johnone.dart';
import 'package:nebible/data/Johnthree.dart';
import 'package:nebible/data/Johntwo.dart';
import 'package:nebible/data/Jonah.dart';
import 'package:nebible/data/Joshua.dart';
import 'package:nebible/data/Jude.dart';
import 'package:nebible/data/Judges.dart';
import 'package:nebible/data/Kingsone.dart';
import 'package:nebible/data/Kingstwo.dart';
import 'package:nebible/data/Lamentations.dart';
import 'package:nebible/data/Leviticus.dart';
import 'package:nebible/data/Luke.dart';
import 'package:nebible/data/Malachi.dart';
import 'package:nebible/data/Mark.dart';
import 'package:nebible/data/Matthew.dart';
import 'package:nebible/data/Micah.dart';
import 'package:nebible/data/Nahum.dart';
import 'package:nebible/data/Nehemiah.dart';
import 'package:nebible/data/Numbers.dart';
import 'package:nebible/data/Obadiah.dart';
import 'package:nebible/data/Peterone.dart';
import 'package:nebible/data/Petertwo.dart';
import 'package:nebible/data/Philemon.dart';
import 'package:nebible/data/Philippians.dart';
import 'package:nebible/data/Proverbs.dart';
import 'package:nebible/data/Psalms.dart';
import 'package:nebible/data/Revelation.dart';
import 'package:nebible/data/Romans.dart';
import 'package:nebible/data/Ruth.dart';
import 'package:nebible/data/Samuelone.dart';
import 'package:nebible/data/Samueltwo.dart';
import 'package:nebible/data/Song.dart';
import 'package:nebible/data/Thessaloniansone.dart';
import 'package:nebible/data/Thessalonianstwo.dart';
import 'package:nebible/data/Timothyone.dart';
import 'package:nebible/data/Timothytwo.dart';
import 'package:nebible/data/Titus.dart';
import 'package:nebible/data/Zechariah.dart';
import 'package:nebible/data/Zephaniah.dart';

import 'package:nebible/data/exodus.dart';
import 'package:nebible/data/genesis.dart';
import 'BibleChapter.dart';

class BibleChapterlist {
  String chapterNepaliName;
  String chapterEnglishName;
  String autherName;
  int totalChapter;
  int totalVerse;
  int totalWords;
  String englishIntro;
  String nepaliIntro;
  List<Biblechapter> chapters;

  BibleChapterlist(
      {this.chapterEnglishName,
      this.chapterNepaliName,
      this.autherName,
      this.totalChapter,
      this.totalVerse,
      this.totalWords,
      this.englishIntro,
      this.nepaliIntro,
      this.chapters});
}

List<BibleChapterlist> books = [
  //Gensisi
  BibleChapterlist(
      chapterEnglishName: 'Genesis',
      chapterNepaliName: 'उत्पत्ति',
      autherName: 'Moses(माेशा)',
      totalChapter: 50,
      totalVerse: 1533,
      totalWords: 38262,
      englishIntro:
          'The book recounts the origins of the heavens and earth, of all created things, of the human family, of God\'s covenant relationship with humans, of sin, of redemption, of nations, languages, and God\'s chosen people Israel. Genesis teaches us about the problem of sin and God\'s plan of salvation.',
      nepaliIntro: 'Neali introduction is unavailbae',
      chapters: [
        g1,
        g2,
        g3,
        g4,
        g5,
        g6,
        g7,
        g8,
        g9,
        g10,
        g11,
        g12,
        g13,
        g14,
        g15,
        g16,
        g17,
        g18,
        g19,
        g20,
        g21,
        g22,
        g23,
        g24,
        g25,
        g26,
        g27,
        g28,
        g29,
        g30,
        g31,
        g32,
        g33,
        g34,
        g35,
        g36,
        g37,
        g38,
        g39,
        g40,
        g41,
        g42,
        g43,
        g44,
        g45,
        g46,
        g47,
        g48,
        g49,
        g50
      ]),

  //excodus
  BibleChapterlist(
      chapterEnglishName: 'Exodus',
      chapterNepaliName: 'प्रस्थान',
      autherName: 'Moses(माेशा)',
      totalChapter: 40,
      totalVerse: 1213,
      totalWords: 32685,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [e1]),

  //Leviticus
  BibleChapterlist(
      chapterEnglishName: 'Leviticus',
      chapterNepaliName: 'लेवी',
      autherName: 'Moses(माेशा)',
      totalChapter: 27,
      totalVerse: 859,
      totalWords: 24541,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [l1]),

  //number
  BibleChapterlist(
      chapterEnglishName: 'Numbers',
      chapterNepaliName: 'गन्ती',
      autherName: 'Moses(माेशा)',
      totalChapter: 36,
      totalVerse: 1289,
      totalWords: 32896,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [n1]),

  //deturofalsemy
  BibleChapterlist(
      chapterEnglishName: 'Deuteronomy',
      chapterNepaliName: 'व्यवस्था',
      autherName: 'Moses(माेशा)',
      totalChapter: 34,
      totalVerse: 959,
      totalWords: 28352,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [d1]),

  //jeshu
  BibleChapterlist(
      chapterEnglishName: 'Joshua',
      chapterNepaliName: 'यहोशू',
      autherName: 'Joshua(यहोशू)',
      totalChapter: 24,
      totalVerse: 658,
      totalWords: 18854,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [j1]),

  //Judge
  BibleChapterlist(
      chapterEnglishName: 'Judges',
      chapterNepaliName: 'न्यायाधीश',
      autherName: '',
      totalChapter: 21,
      totalVerse: 618,
      totalWords: 18966,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ju1]),

//Ruth
  BibleChapterlist(
      chapterEnglishName: 'Ruth',
      chapterNepaliName: 'रूथ',
      autherName: '',
      totalChapter: 4,
      totalVerse: 85,
      totalWords: 2574,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [r1]),

  //samuel 1
  BibleChapterlist(
      chapterEnglishName: '1 Samuel',
      chapterNepaliName: '१ शमूएल',
      autherName: '',
      totalChapter: 31,
      totalVerse: 810,
      totalWords: 25048,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [s1]),

  //2 samuel
  BibleChapterlist(
      chapterEnglishName: '2 Samuel',
      chapterNepaliName: '२ शमूएल',
      autherName: '',
      totalChapter: 24,
      totalVerse: 695,
      totalWords: 20600,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [sa1]),

  //1 king
  BibleChapterlist(
      chapterEnglishName: '1 Kings',
      chapterNepaliName: '१ राजा',
      autherName: '',
      totalChapter: 22,
      totalVerse: 816,
      totalWords: 24513,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [k1]),

  //
  BibleChapterlist(
      chapterEnglishName: '2 Kings',
      chapterNepaliName: '२ राजा',
      autherName: '',
      totalChapter: 25,
      totalVerse: 719,
      totalWords: 23517,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ki1]),

  //
  BibleChapterlist(
      chapterEnglishName: '1 Chronicles',
      chapterNepaliName: '१ इतिहास',
      autherName: 'Ezra(एज्रा)',
      totalChapter: 29,
      totalVerse: 942,
      totalWords: 20365,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [c1]),
  //

  BibleChapterlist(
      chapterEnglishName: '2 Chronicles',
      chapterNepaliName: '२ इतिहास',
      autherName: 'Ezra(एज्रा)',
      totalChapter: 36,
      totalVerse: 822,
      totalWords: 26069,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ch1]),

  BibleChapterlist(
      chapterEnglishName: 'Ezra',
      chapterNepaliName: 'एज्रा',
      autherName: 'Ezra(एज्रा)',
      totalChapter: 10,
      totalVerse: 280,
      totalWords: 7440,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ezra1]),

  BibleChapterlist(
      chapterEnglishName: 'Nehemiah',
      chapterNepaliName: 'नहेम्याह',
      autherName: 'Nehemiah(नहेम्याह)',
      totalChapter: 13,
      totalVerse: 406,
      totalWords: 10480,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [nehe1]),

  BibleChapterlist(
      chapterEnglishName: 'Esther',
      chapterNepaliName: 'एस्तर',
      autherName: '',
      totalChapter: 10,
      totalVerse: 167,
      totalWords: 5633,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [es1]),

  BibleChapterlist(
      chapterEnglishName: 'Job',
      chapterNepaliName: 'अय्यूब ',
      autherName: '',
      totalChapter: 42,
      totalVerse: 1070,
      totalWords: 18098,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [es1]),

  BibleChapterlist(
      chapterEnglishName: 'Psalms',
      chapterNepaliName: 'भजनसड्ग्रह',
      autherName: 'Various',
      totalChapter: 150,
      totalVerse: 2461,
      totalWords: 42704,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [p1]),

  BibleChapterlist(
      chapterEnglishName: 'Proverbs',
      chapterNepaliName: 'हितोपदेश',
      autherName: 'Solomon(सोलोमन)',
      totalChapter: 31,
      totalVerse: 915,
      totalWords: 15038,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [pr1]),

  BibleChapterlist(
      chapterEnglishName: 'Ecclesiastes',
      chapterNepaliName: 'उपदेशक',
      autherName: 'Solomon(सोलोमन)',
      totalChapter: 12,
      totalVerse: 222,
      totalWords: 5579,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ec1]),

  BibleChapterlist(
      chapterEnglishName: 'Song of Solomon',
      chapterNepaliName: 'सोलोमनको गीत',
      autherName: 'Solomon(सोलोमन)',
      totalChapter: 8,
      totalVerse: 117,
      totalWords: 2658,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ss1]),

  BibleChapterlist(
      chapterEnglishName: 'Isaiah',
      chapterNepaliName: 'यशैया',
      autherName: 'Isaiah(यशैया)',
      totalChapter: 66,
      totalVerse: 1292,
      totalWords: 37036,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [i1]),

  BibleChapterlist(
      chapterEnglishName: 'Jeremiah',
      chapterNepaliName: 'यर्मिया',
      autherName: 'Jeremiah(यर्मिया)',
      totalChapter: 52,
      totalVerse: 1364,
      totalWords: 42654,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [je1]),

  BibleChapterlist(
      chapterEnglishName: 'Lamentations',
      chapterNepaliName: 'विलाप',
      autherName: 'Jeremiah(यर्मिया)',
      totalChapter: 5,
      totalVerse: 154,
      totalWords: 3411,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [lame1]),

  BibleChapterlist(
      chapterEnglishName: 'Ezekiel',
      chapterNepaliName: 'इजकिएल',
      autherName: 'Ezekiel(इजकिएल)',
      totalChapter: 48,
      totalVerse: 1273,
      totalWords: 39401,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ez1]),

  BibleChapterlist(
      chapterEnglishName: 'Daniel',
      chapterNepaliName: 'दानिएल',
      autherName: 'Daniel(दानिएल)',
      totalChapter: 12,
      totalVerse: 357,
      totalWords: 11602,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [dan1]),

  BibleChapterlist(
      chapterEnglishName: 'Hosea',
      chapterNepaliName: 'हाेशे',
      autherName: 'Hosea(हाेशे)',
      totalChapter: 14,
      totalVerse: 197,
      totalWords: 5174,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [h1]),

  BibleChapterlist(
      chapterEnglishName: 'Joel',
      chapterNepaliName: 'याेएल',
      autherName: 'Joel(याेएल)',
      totalChapter: 3,
      totalVerse: 73,
      totalWords: 2033,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [jo1]),

  BibleChapterlist(
      chapterEnglishName: 'Amos',
      chapterNepaliName: 'आमोस',
      autherName: 'Amos(आमोस)',
      totalChapter: 9,
      totalVerse: 146,
      totalWords: 4216,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [a1]),

  BibleChapterlist(
      chapterEnglishName: 'Obadiah',
      chapterNepaliName: 'ओबदिया',
      autherName: 'Obadiah(ओबदिया)',
      totalChapter: 1,
      totalVerse: 21,
      totalWords: 669,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ob1]),

  BibleChapterlist(
      chapterEnglishName: 'Jonah',
      chapterNepaliName: 'योना',
      autherName: 'Jonah(योना)',
      totalChapter: 4,
      totalVerse: 48,
      totalWords: 1320,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [jona1]),

  BibleChapterlist(
      chapterEnglishName: 'Micah',
      chapterNepaliName: 'मीका',
      autherName: 'Micah(मीका)',
      totalChapter: 7,
      totalVerse: 105,
      totalWords: 3152,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [mi1]),

  BibleChapterlist(
      chapterEnglishName: '1284',
      chapterNepaliName: 'नहूम',
      autherName: '1284(नहूम)',
      totalChapter: 3,
      totalVerse: 47,
      totalWords: 1284,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [na1]),

  BibleChapterlist(
      chapterEnglishName: 'Habakkuk',
      chapterNepaliName: 'हबक्कुक',
      autherName: 'Habakkuk(हबक्कुक)',
      totalChapter: 3,
      totalVerse: 56,
      totalWords: 1475,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ha1]),

  BibleChapterlist(
      chapterEnglishName: 'Zephaniah',
      chapterNepaliName: 'सपन्याह',
      autherName: 'Zephaniah(सपन्याह)',
      totalChapter: 3,
      totalVerse: 53,
      totalWords: 1616,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [z1]),

  BibleChapterlist(
      chapterEnglishName: 'Haggai',
      chapterNepaliName: 'हाग्गै',
      autherName: 'Haggai(हाग्गै)',
      totalChapter: 2,
      totalVerse: 38,
      totalWords: 1130,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [hag1]),

  BibleChapterlist(
      chapterEnglishName: 'Zechariah',
      chapterNepaliName: 'जकरिया',
      autherName: 'Zechariah(जकरिया)',
      totalChapter: 14,
      totalVerse: 211,
      totalWords: 6443,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [zec1]),

  BibleChapterlist(
      chapterEnglishName: 'Malachi',
      chapterNepaliName: 'मलाकी',
      autherName: 'Malachi(मलाकी)',
      totalChapter: 4,
      totalVerse: 55,
      totalWords: 1781,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [mal1]),
//39
  //New Testament 27

  BibleChapterlist(
      chapterEnglishName: 'Matthew',
      chapterNepaliName: 'मत्ती',
      autherName: 'Matthew(मत्ती)',
      totalChapter: 28,
      totalVerse: 1071,
      totalWords: 23343,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [mat1]),

  BibleChapterlist(
      chapterEnglishName: 'Mark',
      chapterNepaliName: 'मार्कूस',
      autherName: 'Mark(मार्कूस)',
      totalChapter: 16,
      totalVerse: 678,
      totalWords: 14949,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [mar1]),

  BibleChapterlist(
      chapterEnglishName: 'Luke',
      chapterNepaliName: 'लूका',
      autherName: 'Luke(लूका)',
      totalChapter: 24,
      totalVerse: 1151,
      totalWords: 25640,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [luk1]),

  BibleChapterlist(
      chapterEnglishName: 'John',
      chapterNepaliName: 'यूहन्ना',
      autherName: 'John(यूहन्ना)',
      totalChapter: 21,
      totalVerse: 879,
      totalWords: 18658,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [joh1]),

  BibleChapterlist(
      chapterEnglishName: 'Acts',
      chapterNepaliName: 'प्रेरित',
      autherName: 'Luke(लूका)',
      totalChapter: 28,
      totalVerse: 1007,
      totalWords: 24229,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ac1]),

  BibleChapterlist(
      chapterEnglishName: 'Romans',
      chapterNepaliName: 'रोमी',
      autherName: 'Paul(पावल)',
      totalChapter: 16,
      totalVerse: 433,
      totalWords: 9422,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [rom1]),

  BibleChapterlist(
      chapterEnglishName: '1 Corinthians',
      chapterNepaliName: '१ कोरिन्थी',
      autherName: 'Paul(पावल)',
      totalChapter: 16,
      totalVerse: 437,
      totalWords: 9462,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [cor1]),

  BibleChapterlist(
      chapterEnglishName: '2 Corinthians',
      chapterNepaliName: '२ कोरिन्थी',
      autherName: 'Paul(पावल)',
      totalChapter: 13,
      totalVerse: 257,
      totalWords: 6046,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [cori1]),

  BibleChapterlist(
      chapterEnglishName: 'Galatians',
      chapterNepaliName: 'गलाती',
      autherName: 'Paul(पावल)',
      totalChapter: 6,
      totalVerse: 149,
      totalWords: 3084,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [gal1]),

  BibleChapterlist(
      chapterEnglishName: 'Ephesians',
      chapterNepaliName: 'एफिसी',
      autherName: 'Paul(पावल)',
      totalChapter: 6,
      totalVerse: 155,
      totalWords: 3022,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ep1]),

  BibleChapterlist(
      chapterEnglishName: 'Philippians',
      chapterNepaliName: 'फिलिप्पी',
      autherName: 'Paul(पावल)',
      totalChapter: 4,
      totalVerse: 104,
      totalWords: 2183,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [phh1]),

  BibleChapterlist(
      chapterEnglishName: 'Colossians',
      chapterNepaliName: 'कलस्सी',
      autherName: 'Paul(पावल)',
      totalChapter: 4,
      totalVerse: 95,
      totalWords: 1979,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [col1]),

  BibleChapterlist(
      chapterEnglishName: '1 Thessalonians',
      chapterNepaliName: '१ थिस्सलोनिकीहरू',
      autherName: 'Paul(पावल)',
      totalChapter: 5,
      totalVerse: 89,
      totalWords: 1837,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [t1]),

  BibleChapterlist(
      chapterEnglishName: '2 Thessalonians',
      chapterNepaliName: '२ थिस्सलोनिकीहरू',
      autherName: 'Paul(पावल)',
      totalChapter: 3,
      totalVerse: 47,
      totalWords: 1022,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [the1]),

  BibleChapterlist(
      chapterEnglishName: '1 Timothy',
      chapterNepaliName: '१ तिमोथी',
      autherName: 'Paul(पावल)',
      totalChapter: 6,
      totalVerse: 113,
      totalWords: 2244,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [ti1]),
  BibleChapterlist(
      chapterEnglishName: '2 Timothy',
      chapterNepaliName: '२ तिमोथी',
      autherName: 'Paul(पावल)',
      totalChapter: 4,
      totalVerse: 83,
      totalWords: 1666,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [tim1]),

  BibleChapterlist(
      chapterEnglishName: 'Titus',
      chapterNepaliName: 'तीतस',
      autherName: 'Paul(पावल)',
      totalChapter: 3,
      totalVerse: 46,
      totalWords: 896,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [tit1]),

  BibleChapterlist(
      chapterEnglishName: 'Philemon',
      chapterNepaliName: 'फिलेमोन',
      autherName: 'Paul(पावल)',
      totalChapter: 1,
      totalVerse: 25,
      totalWords: 430,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [phi1]),

  BibleChapterlist(
      chapterEnglishName: 'Hebrews',
      chapterNepaliName: 'हिब्रू',
      autherName: 'Unknown',
      totalChapter: 13,
      totalVerse: 303,
      totalWords: 6897,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [heb1]),

  BibleChapterlist(
      chapterEnglishName: 'James',
      chapterNepaliName: 'याकूब',
      autherName: 'James(याकूब)',
      totalChapter: 5,
      totalVerse: 108,
      totalWords: 2304,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [jam1]),

  BibleChapterlist(
      chapterEnglishName: '1 Peter',
      chapterNepaliName: '१ पत्रुस',
      autherName: 'Peter(पत्रुस)',
      totalChapter: 5,
      totalVerse: 105,
      totalWords: 2476,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [pe1]),

  BibleChapterlist(
      chapterEnglishName: '2 Peter',
      chapterNepaliName: '२ पत्रुस',
      autherName: 'Peter(पत्रुस)',
      totalChapter: 3,
      totalVerse: 61,
      totalWords: 1553,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [pet1]),

  BibleChapterlist(
      chapterEnglishName: '1 John',
      chapterNepaliName: '१ यूहन्ना',
      autherName: 'John(यूहन्ना)',
      totalChapter: 5,
      totalVerse: 105,
      totalWords: 2517,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [john1]),

  BibleChapterlist(
      chapterEnglishName: '2 John',
      chapterNepaliName: '२ यूहन्ना',
      autherName: 'John(यूहन्ना)',
      totalChapter: 1,
      totalVerse: 13,
      totalWords: 298,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [johne1]),

  BibleChapterlist(
      chapterEnglishName: '3 John',
      chapterNepaliName: '३ यूहन्ना',
      autherName: 'John(यूहन्ना)',
      totalChapter: 1,
      totalVerse: 14,
      totalWords: 294,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [johnt1]),

  BibleChapterlist(
      chapterEnglishName: 'Jude',
      chapterNepaliName: 'यहूदा',
      autherName: 'Jude(यहूदा)',
      totalChapter: 1,
      totalVerse: 25,
      totalWords: 608,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [jude1]),

  BibleChapterlist(
      chapterEnglishName: 'Revelation',
      chapterNepaliName: 'प्रकाश',
      autherName: 'John(यूहन्ना)',
      totalChapter: 22,
      totalVerse: 404,
      totalWords: 11952,
      englishIntro: '',
      nepaliIntro: '',
      chapters: [rev1]),
];

/*
BibleChapterlist(
      chapterEnglishName: '',
      chapterNepaliName: '',
      autherName: '',
      totalChapter: 0,
      totalVerse: 0,
      totalWords: 0,
      englishIntro: '',
      nepaliIntro: '',
      chapters: []),
 */
