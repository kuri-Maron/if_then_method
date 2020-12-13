import 'package:flutter/cupertino.dart';

class IfThenData {
  IfThenData({
    @required this.key,
    this.ifText = '',
    this.thenText = '',
    this.exceptionText = '',
    this.score = 0,
  });
  Key key;
  String ifText;
  String thenText;
  String exceptionText;
  int score;
}
