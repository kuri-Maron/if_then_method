import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// アイテム作成ページ
class CreateItemPage extends StatefulWidget {
  final User user;
  // 次に登録するアイテムのorderを算出するために利用
  final num maxOrder;
  CreateItemPage(this.user, this.maxOrder);

  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formKey = GlobalKey<FormState>();
  String _ifText;
  String _thenText;
  String _exceptionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE'),
      ),
      // スクロール可能な画面中央配置
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          // サイズを指定
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // TODO: 汎用性のある関数に抽出
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'if',
                        hintText: 'もし〜ならば',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '必須入力項目です';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        _ifText = value;
                      }),
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
                      onSaved: (value) => setState(() {
                        _thenText = value;
                      }),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        labelText: "exception",
                        hintText: ' 例外のアクションを入力',
                      ),
                      onSaved: (value) => setState(() {
                        _exceptionText = value;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      // 作成ボタン
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor: MaterialStateProperty.all(
                            const Color(0xff00053A),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            this._formKey.currentState.save();
                            CollectionReference ifThenlist = FirebaseFirestore
                                .instance
                                .collection('users_subCollection')
                                .doc(widget.user.uid)
                                .collection('ifThenList');

                            await ifThenlist.add({
                              'ifText': _ifText,
                              'thenText': _thenText,
                              'exceptionText': _exceptionText,
                              'score': 0,
                              'order': widget.maxOrder + 100,
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('OK'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      // ),
    );
  }
}
