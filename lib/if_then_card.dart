import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:if_then_method/edit_item_page.dart';
import 'package:if_then_method/if_then_data.dart';

// リストビューの各アイテムWidget
class IfThenCard extends StatelessWidget {
  IfThenCard(
    this.ifThenData,
    // Key key,
    // this.callBackIncrementScore,
    // this.callBackDecrementScore,
    // this.callBackDeleteCard,
    // this.callBackEditCard,
  ) : super(key: ifThenData.key);

  final IfThenData ifThenData;
  // final Key key;

  // firestore連携前のメソッド群
  // final Function callBackIncrementScore;
  // final Function callBackDecrementScore;
  // final Function callBackDeleteCard;
  // final Function callBackEditCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExpansionTile(
            title: DefaultTextStyle.merge(
              style: TextStyle(
                color: const Color(0xff00053A),
              ),
              child: Column(
                // TODO: 随所、コード共通化したい
                children: <Widget>[
                  // 1行目
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'if',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2行目
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Flexible(child: Text(ifThenData.ifText)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'then',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Flexible(child: Text(ifThenData.thenText)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              //　タイルの拡張エリア
              ListTile(
                title: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: const Color(0xff00053A),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'exception',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          top: 8.0,
                          right: 8.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          children: [
                            Flexible(child: Text(ifThenData.exceptionText))
                          ],
                        ),
                      ),
                      //ボタン配置の行
                      Row(
                        mainAxisAlignment: MainAxisAlignment.values[4],
                        children: [
                          //TODO： TextStyleの外だし,ButtonThemeがあればそこで定義する
                          FlatButton(
                            child: const Text(
                              '編集',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            textColor: const Color(0xff00053A),
                            shape: const UnderlineInputBorder(),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditItemPage(ifThenData)),
                              );
                            },
                          ),
                          // TODO: リリース後に、実装予定（push通知が優先度高）
                          // FlatButton(
                          //   child: const Text(
                          //     'アーカイブ',
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 15,
                          //     ),
                          //   ),
                          //   textColor: const Color(0xff00053A),
                          //   shape: const UnderlineInputBorder(),
                          //   onPressed: () {},
                          // ),
                          FlatButton(
                            child: const Text(
                              '削除',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            textColor: const Color(0xff00053A),
                            shape: const UnderlineInputBorder(),
                            // onPressed: callBackDeleteCard,
                            onPressed: () {
                              ifThenData.reference.delete();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // カード下部の固定行
          Row(
            children: [
              //アイコンの配置バランス調整
              Spacer(
                flex: 3,
              ),
              //インクリメント
              IconButton(
                icon: Icon(Icons.arrow_circle_up),
                //TODO: 関数実装
                onPressed: () => ifThenData.reference
                    .update({'score': FieldValue.increment(1)}),
              ),
              Spacer(
                flex: 3,
              ),
              //デクリメント
              IconButton(
                icon: Icon(Icons.arrow_circle_down),
                onPressed: () => ifThenData.reference
                    .update({'score': FieldValue.increment(-1)}),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('score: ${ifThenData.score}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
