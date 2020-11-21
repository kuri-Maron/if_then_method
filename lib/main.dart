// import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'if then',
      theme: ThemeData(
        // brightness: Brightness.dark, //これでテキストカラーを白にすることも可能だが、他に影響あり
        primaryColor: const Color(0xff00053A),
        scaffoldBackgroundColor: const Color(0xff00053A),
        // textTheme: TextTheme(
        //   bodyText1: TextStyle(), //このコード未理解
        //   bodyText2: TextStyle(),
        // ).apply(
        //   bodyColor: Colors.white,
        //   displayColor: Colors.white,
        // ),
      ),
      home: MyHomePage(
          title: 'if then Method'
              ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // final items = List<String>.generate(10000, (i) => "Item $i");
  final items = List<String>.generate(10000, (i) => "$i");

  //stateクラスの中に、フィールドに対しての操作をするメソッドを定義する
  void _incrementCounter() {
    //   setState(() {
    //     _counter++;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    //カードレイアウトの実装不採用案１
    // var gridItemList = [
    //   Container(),
    //   IconButton(
    //     icon: Icon(Icons.arrow_circle_up),
    //     onPressed: () {},
    //   ),
    //   Container(),
    //   IconButton(
    //     icon: Icon(Icons.arrow_circle_down),
    //     onPressed: () {},
    //   ),
    //   Container(),
    //   Icon(Icons.keyboard_arrow_down),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // itemExtent: 50, //指定の高さをもたせる？
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            // child: Text('${items[index]}'),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('if'),
                      Spacer(),
                      Text('score: ${items[index]}')
                    ],
                  ),
                ),
                Padding(
                  // padding: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Text('頭がモヤモヤしたら'),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [Text('ゼロメモを書く。')],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      //アイコンの配置バランス調整
                      Container(
                        child: SizedBox(
                          width: 24.0,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.arrow_circle_up),
                        onPressed: () {},
                      ),
                      // Container(),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.arrow_circle_down),
                        onPressed: () {},
                      ),
                      Spacer(),
                      // Container(),
                      Icon(Icons.keyboard_arrow_down),

                      //カード内icon行のレイアウト案１
                      // Expanded(
                      //   child: SizedBox(
                      //     height: 50.0,
                      //     child: GridView.count(
                      //       crossAxisCount: 6,
                      //       // shrinkWrap: true,
                      //       children: gridItemList,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: const Color(0xff32397C),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

// 関数でただ単に、指定のウィジェットを返す。直接書き込むべきだと気づく。
// Widget _getIconButton(IconData iconData) {
//   return IconButton(
//     icon: Icon(iconData),
//     onPressed: () {},
//   );
// }
}
