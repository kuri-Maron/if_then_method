// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:if_then_method/ithen_Item.dart';

class CreateItemPage extends StatefulWidget {
  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formKey = GlobalKey<FormState>();
  String _ifText = 'X';
  String _thenText = 'Y';
  String _exceptionText = 'Z';

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
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                // color: Colors.grespaceAroundy,
                // alignment: Alignment.topCentespaceAroundr,
                // alignment: Alignment.center,
                padding: EdgeInsets.all(50.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: ElevatedButton(
                        onPressed: () {
                          print("test");
                          if (_formKey.currentState.validate()) {
                            // Process data.
                            this._formKey.currentState.save();
                            // Map<String, String> item = {
                            //   'ifText': _ifText,
                            //   'thenTest': _thenText,
                            //   'exceptionText': _exceptionText,
                            IfthenCard item = IfthenCard(
                              ifText: _ifText,
                              thenText: _thenText,
                              exceptionText: _exceptionText,
                            );
                            // };
                            Navigator.of(context).pop(item);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(_ifText + _thenText + _exceptionText),
          ],
        ),
      ),
    );
  }
}
