import 'package:flutter/material.dart';

//TODO: 多分、ステートフルにする必要がある！
class IfthenCard extends StatelessWidget {
  const IfthenCard({
    Key key,
    // @required List<String> items,
    String ifText,
    String thenText,
    String exceptionText,
    int index,
    // })  : _items = items,
  })  : _ifText = ifText,
        _thenText = thenText,
        _exceptionText = exceptionText,
        _index = index,
        super(key: key);

  // final List<String> _items;
  final String _ifText;
  final String _thenText;
  final String _exceptionText;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Card(
      // child: Text('${items[index]}'),
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: DefaultTextStyle.merge(
              style: TextStyle(
                color: const Color(0xff00053A),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('if'),
                        // Spacer(),
                        // Text('score: ${items[index]}')
                      ],
                    ),
                  ),
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
                          _ifText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text('then')],
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
                      children: [Text(_thenText)],
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
                              _exceptionText,
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
                            onPressed: () {},
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
              IconButton(
                icon: Icon(Icons.arrow_circle_up),
                //TODO: 関数実装
                onPressed: () {},
              ),
              // Container(),
              Spacer(
                flex: 3,
              ),
              IconButton(
                icon: Icon(Icons.arrow_circle_down),
                //TODO: 関数実装
                onPressed: () {},
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                // child: Text('score: ${_index}'),
                child: Text('score: $_index'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
