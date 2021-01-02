import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:if_then_method/if_then_data.dart';

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
                            // IfThenData item = IfThenData(
                            //   key: UniqueKey(),
                            //   ifText: _ifText,
                            //   thenText: _thenText,
                            //   exceptionText: _exceptionText,
                            //   score: widget.ifThenData.score,
                            // );
                            // // };
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
