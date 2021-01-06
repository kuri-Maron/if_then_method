// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:if_then_method/auth_page.dart';
import 'package:if_then_method/create_item_page.dart';
import 'package:if_then_method/if_then_data.dart';

import 'if_then_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  // final FirebaseAuth auth = FirebaseAuth.instance;

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
      home: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              // print(snapshot);
              // User hoge = snapshot.data;
              return MyHomePage(
                title: 'if then Method',
                user: snapshot.data,
              );
            } else {
              // return Container(child: LinearProgressIndicator());
              // return Container(child: CircularProgressIndicator());
              return AuthPage();
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num maxOrder = 0;

  @override
  Widget build(BuildContext context) {
    // Function deleteCard = (IfThenData item) {
    //   setState(() {
    //     // _items.removeAt(i);
    //     _items.remove(item);
    //   });
    // };

    return Scaffold(
      appBar: AppBar(
        // leading: Text(widget.user.photoURL),
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(widget.user.photoURL)),
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem(
                child: TextButton(
                  child: Text('Sign out'),
                  onPressed: () async {
                    try {
                      await auth.signOut();
                    } catch (e) {
                      print(e);
                      return null;
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),

      // body: ReorderableListView(
      //   onReorder: (int oldIndex, int newIndex) {
      //     print('$oldIndex --> $newIndex .');
      //     if (oldIndex < newIndex) newIndex -= 1;
      //     final IfThenData item = _items.removeAt(oldIndex);
      //
      //     setState(() {
      //       _items.insert(newIndex, item);
      //     });
      //   },
      //   children: [
      //     for (IfThenData item in _items)
      //       IfThenCard(
      //         item,
      //         callBackIncrementScore: () {
      //           setState(() {
      //             item.score++;
      //           });
      //         },
      //         callBackDecrementScore: () {
      //           setState(() {
      //             item.score--;
      //           });
      //         },
      //         callBackDeleteCard: () {
      //           deleteCard(item);
      //         },
      //         callBackEditCard: (IfThenData newItem) {
      //           if (newItem != null)
      //             setState(() {
      //               item = newItem;
      //             });
      //         },
      //       ),
      //   ],
      // ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        //TODO: 関数の実装
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateItemPage(widget.user, maxOrder)),
          );
        },
        // backgroundColor: const Color(0xff32397C),
        backgroundColor: Colors.pink,
        tooltip: 'CREATE',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users_subCollection')
          .doc(widget.user.uid)
          .collection('ifThenList')
          .orderBy('order', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildReorderableList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildReorderableList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ReorderableListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      onReorder: (int oldIndex, int newIndex) {
        print('$oldIndex --> $newIndex .');
        DocumentReference documentReference = snapshot[oldIndex].reference;
        if (newIndex == 0) {
          print('トップへソート！');
          num newOrder = snapshot[newIndex].data()['order'] + 100;
          documentReference.update({'order': newOrder});
        } else if (newIndex == snapshot.length) {
          newIndex -= 1;
          print('ボトムへソート！');
          num newOrder = (0 + snapshot[newIndex].data()['order']) / 2;
          documentReference.update({'order': newOrder});
        }
        // 要素を下へソートしたとき
        else if (oldIndex < newIndex) {
          newIndex -= 1;
          var previousOrder = snapshot[newIndex].data()['order'];
          var nextOrder = snapshot[newIndex + 1].data()['order'];
          documentReference.update({'order': (previousOrder + nextOrder) / 2});
          print('previous: $previousOrder, next: $nextOrder');
        } else if (oldIndex > newIndex) {
          var nextOrder = snapshot[newIndex].data()['order'];
          var previousOrder = snapshot[newIndex - 1].data()['order'];
          documentReference.update({'order': (previousOrder + nextOrder) / 2});
          print('previous: $previousOrder, next: $nextOrder');
        }
        // TODO firestoreでの並び替えロジック実装
        // final IfThenData item = _items.removeAt(oldIndex);
        //
        // setState(() {
        //   _items.insert(newIndex, item);
        // });
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final ifThenData = IfThenData.fromSnapshot(data);
    if (maxOrder < ifThenData.order) maxOrder = ifThenData.order;
    return IfThenCard(ifThenData);
  }
}
