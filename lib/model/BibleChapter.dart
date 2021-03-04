import 'package:nebible/model/BibleVerse.dart';
import 'dart:core';

class Biblechapter {
  String chapter;
  List<BibleVerse> verse;
  Biblechapter({
    this.chapter,
    this.verse,
  });
}
