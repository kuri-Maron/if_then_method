import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class IfThenData {
  IfThenData({
    @required this.key,
    this.ifText = '',
    this.thenText = '',
    this.exceptionText = '',
    this.score = 0,
  });

  IfThenData.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['ifText'] != null),
        assert(map['thenText'] != null),
        assert(map['exceptionText'] != null),
        assert(map['score'] != null),
        ifText = map['ifText'],
        thenText = map['thenText'],
        exceptionText = map['exceptionText'],
        score = map['score'],
        key = UniqueKey();

  IfThenData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Key key;
  String ifText;
  String thenText;
  String exceptionText;
  int score;
  DocumentReference reference;
}
