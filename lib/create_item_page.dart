// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateItemPage extends StatefulWidget {
  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE'),
      ),
      //もっと他の箇所で定義したい。テキストスタイルは。現状だと、sccafoldの仕組みで一旦再定義されるから、しょうがなく下記に定義。
      body: DefaultTextStyle.merge(
        style: TextStyle(
          color: Colors.white,
        ),
        child: Form(
          child: Container(
            // alignment: Alignment.topCenter,
            // alignment: Alignment.center,
            padding: EdgeInsets.all(50.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: "if",
                    hintText: 'もし〜ならば',
                  ),
                  validator: (value) {
                    // TODO： テキストカラーを白にする
                    if (value.isEmpty) {
                      return '必須入力です';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: "then",
                    hintText: '〜する',
                  ),
                  validator: (value) {
                    // TODO： テキストカラーを白にする
                    if (value.isEmpty) {
                      return '必須入力です';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: "exception",
                    hintText: ' 例外のアクションを入力',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
