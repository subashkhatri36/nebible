import 'dart:core';

class Bhajangeet {
  String title;
  String bhajannum;
  String tal;
  String link;
  List<String> bhajan;
  List<String> chordbhajan;

  Bhajangeet(
      {this.title,
      this.bhajannum,
      this.tal,
      this.link,
      this.bhajan,
      this.chordbhajan});

  void settal(String gettal) {
    tal = gettal;
  }

  String gettal() {
    return tal;
  }

  void setlink(String getlink) {
    link = getlink;
  }

  String getlink() {
    return link;
  }

  void settitle(String gettitle) {
    title = gettitle;
  }

  String gettitle() {
    return title;
  }

  void setbhajannum(String getbhajannum) {
    bhajannum = getbhajannum;
  }

  String getbhajannum() {
    return bhajannum;
  }

  void setbhajan(List<String> getbhajan) {
    bhajan = getbhajan;
  }

  List<String> getbhajan() {
    return bhajan;
  }

  void setchordbhajan(List<String> getchordbhajan) {
    chordbhajan = getchordbhajan;
  }

  List<String> getchordbhajan() {
    return chordbhajan;
  }
}
