import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateItemPage extends StatefulWidget {
  final num maxOrder;

  CreateItemPage(this.maxOrder);

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
                    // buildTextFormField(
                    //   _ifText,
                    //   labelText: 'if',
                    //   hintText: 'もし〜ならば',
                    //   shouldValidate: true,
                    // ),
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
                                .doc("testUser1")
                                .collection('ifThenList');

                            await ifThenlist.add({
                              'ifText': _ifText,
                              'thenText': _thenText,
                              'exceptionText': _exceptionText,
                              'score': 0,
                              'order': widget.maxOrder + 100,
                            });
                            Navigator.of(context).pop();

                            // IfThenData item = IfThenData(
                            //   key: UniqueKey(),
                            //   ifText: _ifText,
                            //   thenText: _thenText,
                            //   exceptionText: _exceptionText,
                            // );
                            // Navigator.of(context).pop(item);
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

// todo コールバッグ対応のlesswidgetか、関数で原始的に条件分岐させるか？（汎用性低い）
//   TextFormField buildTextFormField(
//   String state, {
//   String labelText,
//   String hintText,
//   bool shouldValidate,
// }) {
//   return TextFormField(
//     style: TextStyle(
//       color: Colors.white,
//     ),
//     decoration: InputDecoration(
//       labelText: labelText,
//       hintText: hintText,
//     ),
//     validator: shouldValidate
//         ? (value) {
//             if (value.isEmpty) {
//               return '必須入力項目です';
//             }
//             return null;
//           }
//         : null,
//     onSaved: (value) => setState(() {
//       print('state: $state');
//       _ifText = value;
//       print('state: $state');
//     }),
//   );
// }
