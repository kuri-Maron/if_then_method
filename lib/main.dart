// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:if_then_method/create_item_page.dart';
import 'package:if_then_method/ithen_Item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'if then',
      theme: ThemeData(
        // TODO: ダークテーマをベースにテキストカラーやカードバックグランドだけ、適宜スタイルカスタマイズすること
        brightness: Brightness.dark, //これでテキストカラーを白にすることも可能だが、他に影響あり
        primaryColor: const Color(0xff00053A),
        scaffoldBackgroundColor: const Color(0xff00053A),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        // accentTextTheme: TextTheme(),
        // textTheme: TextTheme(
        //   bodyText1: TextStyle(), //このコード未理解
        //   bodyText2: TextStyle(),
        // ).apply(
        //   bodyColor: Colors.white,
        //   displayColor: Colors.white,
        // ),
      ),
      home: MyHomePage(
        title: 'if then Method',
      ),
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
  // var _items = List<String>.generate(3, (i) => "$i");
  var _items = List<IfthenCard>.generate(2, (i) {
    return IfthenCard(
      ifText: 'hoge',
      thenText: 'fuga',
      exceptionText: 'bar',
      index: i,
    );
  });

  //stateクラスの中に、フィールドに対しての操作をするメソッドを定義する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // itemExtent: 50, //指定の高さをもたせる？
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _items[index];
          // return IfthenCard(
          //   // items: _items,
          //   ifText: 'hoge',
          //   thenText: 'fuga',
          //   exceptionText: 'bar',
          //   index: index,
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //TODO: 関数の実装
        onPressed: () async {
          var item = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateItemPage()),
          );
          setState(() {
            _items.add(item);
          });
        },
        backgroundColor: const Color(0xff32397C),
        tooltip: 'CREATE',
        child: Icon(Icons.add),
      ),
    );
  }
}
