import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// データモデルクラス
class IfThenData {
  // デフォルトのコンストラクタ
  IfThenData({
    @required this.key,
    this.ifText = '',
    this.thenText = '',
    this.exceptionText = '',
    this.score = 0,
  });

  // Mapから変換する名前付きコンストラクタ
  IfThenData.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['ifText'] != null),
        assert(map['thenText'] != null),
        assert(map['exceptionText'] != null),
        assert(map['score'] != null),
        assert(map['order'] != null),
        ifText = map['ifText'],
        thenText = map['thenText'],
        exceptionText = map['exceptionText'],
        score = map['score'],
        order = map['order'],
        // key = UniqueKey();
        key = ValueKey(reference.id);

  // Snapshotから変換する名前付きコンストラクタ
  IfThenData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  // フィールド
  Key key;
  String ifText;
  String thenText;
  String exceptionText;
  int score;
  DocumentReference reference;
  num order;
}
