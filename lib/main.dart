// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:if_then_method/create_item_page.dart';
import 'package:if_then_method/if_then_data.dart';

import 'if_then_card.dart';
// import 'package:if_then_method/if_then_item_sample2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'if then',
      theme: ThemeData(
        // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
        // TODO: ダークテーマをベースにテキストカラーやカードバックグランドだけ、適宜スタイルカスタマイズすること
        brightness: Brightness.dark, //これでテキストカラーを白にすることも可能だが、他に影響あり
        primaryColor: const Color(0xff00053A),
        scaffoldBackgroundColor: const Color(0xff00053A),
        cardTheme: CardTheme(
          color: Colors.white,
          // color: Colors.white70,
        ),
        iconTheme: IconThemeData(
          color: const Color(0xff00053A),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        // accentTextTheme: TextTheme(),
        textTheme: TextTheme(
          bodyText1: TextStyle(), //このコード未理解
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: const Color(0xff00053A),
          displayColor: const Color(0xff00053A),
        ),
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
  List<IfThenData> _items = List<IfThenData>.generate(
      2,
      (index) => IfThenData(
            key: UniqueKey(),
            ifText: 'hoge',
            thenText: 'fuga',
            exceptionText: 'bar',
          ));

  @override
  Widget build(BuildContext context) {
    Function deleteCard = (int i) {
      setState(() {
        _items.removeAt(i);
      });
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {},
        children: [
          for (IfThenData item in _items)
            IfThenCard(
              item,
              callBackIncrementScore: () {
                setState(() {
                  item.score++;
                });
              },
              callBackDecrementScore: () {
                setState(() {
                  item.score--;
                });
              },
              callBackDeleteCard: () {
                // deleteCard(index);
              },
              callBackEditCard: (IfThenData newItem) {
                if (newItem != null)
                  setState(() {
                    item = newItem;
                  });
              },
            ),
        ],
      ),
      // body: ListView.builder(
      //   // shrinkWrap: true,
      //   itemCount: _items.length + 1,
      //   itemBuilder: (context, index) {
      //     return index != _items.length
      //         // ? _items[index]
      //         ? IfThenCard(
      //             _items[index],
      //             callBackIncrementScore: () {
      //               setState(() {
      //                 _items[index].score++;
      //               });
      //             },
      //             callBackDecrementScore: () {
      //               setState(() {
      //                 _items[index].score--;
      //               });
      //             },
      //             callBackDeleteCard: () {
      //               deleteCard(index);
      //             },
      //             callBackEditCard: (IfThenData item) {
      //               if (item != null)
      //                 setState(() {
      //                   _items[index] = item;
      //                 });
      //             },
      //           )
      //         : SizedBox(width: 1, height: 65); // FABの下のテキストが見えなくなるのを防ぐ
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        //TODO: 関数の実装
        onPressed: () async {
          var item = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateItemPage()),
          );
          if (item != null)
            setState(() {
              _items.add(item);
            });
        },
        // backgroundColor: const Color(0xff32397C),
        backgroundColor: Colors.pink,
        tooltip: 'CREATE',
        child: Icon(Icons.add),
      ),
    );
  }
}
