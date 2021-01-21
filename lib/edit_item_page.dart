import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:if_then_method/if_then_data.dart';

// TODO: 作成と編集のclassを一つにまとめれないか検討する
// 編集ページ
class EditItemPage extends StatefulWidget {
  EditItemPage(this.ifThenData);
  final IfThenData ifThenData;

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
  String _ifText;
  String _thenText;
  String _exceptionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT'),
      ),
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
                    // TODO: 作成と編集で関数の共通化するべき（または、ページごと）
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      initialValue: widget.ifThenData.ifText,
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
                      initialValue: widget.ifThenData.thenText,
                      decoration: const InputDecoration(
                        labelText: "then",
                        hintText: '〜する',
                      ),
                      validator: (value) {
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
                      initialValue: widget.ifThenData.exceptionText,
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor: MaterialStateProperty.all(
                            const Color(0xff00053A),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            this._formKey.currentState.save();
                            widget.ifThenData.reference.update({
                              'ifText': _ifText,
                              'thenText': _thenText,
                              'exceptionText': _exceptionText,
                              'score': widget.ifThenData.score,
                              'order': widget.ifThenData.order,
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
