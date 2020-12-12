import 'package:flutter/material.dart';

class IfThenCard extends StatelessWidget {
  IfThenCard({
    Key key,
    this.ifText,
    this.thenText,
    this.exceptionText,
    this.score,
    this.callBackIncrementScore,
    this.callBackDecrementScore,
    this.callBackDeleteCard,
  }) :
// score = score,
        super(key: key);

  final String ifText;
  final String thenText;
  final String exceptionText;
  final int score;
  final Function callBackIncrementScore;
  final Function callBackDecrementScore;
  final Function callBackDeleteCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: DefaultTextStyle.merge(
              style: TextStyle(
                color: const Color(0xff00053A),
              ),
              child: Column(
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
                        Text(
                          ifText,
                        ),
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
                      children: [Text(thenText)],
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
                            Text(
                              exceptionText,
                            )
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
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: const Text(
                              'アーカイブ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            textColor: const Color(0xff00053A),
                            shape: const UnderlineInputBorder(),
                            onPressed: () {},
                          ),
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
                            onPressed: callBackDeleteCard,
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
                onPressed: callBackIncrementScore,
              ),
              // Container(),
              Spacer(
                flex: 3,
              ),
              //デクリメント
              IconButton(
                icon: Icon(Icons.arrow_circle_down),
                onPressed: callBackDecrementScore,
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                // child: Text('score: ${_index}'),
                // child: Text('score: ${widget.score}'),
                child: Text('score: $score'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class _IfThenCardState extends State<IfThenCard> {
//   int _score;
//   @override
//   void initState() {
//     super.initState();
//     _score = widget.score;
//   }
//
//
//
//
// }
