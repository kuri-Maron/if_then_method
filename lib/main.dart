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
        // brightness: Brightness.dark,  //これでテキストカラーを白にすることも可能だが、他に影響あり
        primaryColor: const Color(0xff00053A),
        scaffoldBackgroundColor: const Color(0xff00053A),
        textTheme: TextTheme(
          bodyText1: TextStyle(), //このコード未理解
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
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

  //stateクラスの中に、フィールドに対しての操作をするメソッドを定義する
  void _incrementCounter() {
    //   setState(() {
    //     _counter++;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'free text',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: const Color(0xff32397C),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
