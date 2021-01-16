// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:if_then_method/auth_page.dart';
import 'package:if_then_method/create_item_page.dart';
import 'package:if_then_method/if_then_card.dart';
import 'package:if_then_method/if_then_data.dart';

Future<void> main() async {
  //firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'if then',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff00053A),
        scaffoldBackgroundColor: const Color(0xff00053A),
        // Cardのテーマ
        cardTheme: CardTheme(
          color: Colors.white,
        ),
        // Iconのテーマ
        iconTheme: IconThemeData(
          color: const Color(0xff00053A),
        ),
        // Inputのテーマ
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        // Textのテーマ
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
              return MyHomePage(
                title: 'if then Method',
                user: snapshot.data,
              );
            } else {
              return AuthPage();
            }
          }),
    );
  }
}

// メニューバーのリスト（SignOutのみ実装）
enum MenuList { SignOut, HowTO, SortOrderDesc }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  // ログイン中のユーザ
  final User user;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 　macOrder初期値設定
  num maxOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 丸いレイアウトにする
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(widget.user.photoURL)),
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
            // TODO: 関数の外だし
            onSelected: (MenuList value) async {
              //　引数によって、処理を分岐
              switch (value) {
                case MenuList.SignOut:
                  try {
                    await auth.signOut();
                  } catch (e) {
                    print(e);
                    return null;
                  }
                  print(value);
                  break;

                default:
                  print(value);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuList>>[
              PopupMenuItem(
                value: MenuList.SignOut,
                child: Text('Sign out'),
              ),
            ],
          )
        ],
      ),
      body: _buildBody(context),
      // FABウィジェット
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateItemPage(
                widget.user,
                maxOrder,
              ),
            ),
          );
        },
        backgroundColor: Colors.pink,
        tooltip: 'CREATE',
        child: Icon(Icons.add),
      ),
    );
  }

  // bodyのbuild関数
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

  // ソート可能なリストビュー
  Widget _buildReorderableList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ReorderableListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      onReorder: (int oldIndex, int newIndex) {
        DocumentReference documentReference = snapshot[oldIndex].reference;
        if (newIndex == 0) {
          // トップへソート
          num newOrder = snapshot[newIndex].data()['order'] + 100;
          documentReference.update({'order': newOrder});
        } else if (newIndex == snapshot.length) {
          // ボトムへソート
          newIndex -= 1;
          num newOrder = (0 + snapshot[newIndex].data()['order']) / 2;
          documentReference.update({'order': newOrder});
        } else if (oldIndex < newIndex) {
          // 要素を下へソート
          newIndex -= 1;
          var previousOrder = snapshot[newIndex].data()['order'];
          var nextOrder = snapshot[newIndex + 1].data()['order'];
          documentReference.update({'order': (previousOrder + nextOrder) / 2});
        } else if (oldIndex > newIndex) {
          // 要素を上へソート
          var nextOrder = snapshot[newIndex].data()['order'];
          var previousOrder = snapshot[newIndex - 1].data()['order'];
          documentReference.update({'order': (previousOrder + nextOrder) / 2});
        }
      },
    );
  }

  //リストビューの各アイテム
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final ifThenData = IfThenData.fromSnapshot(data);
    if (maxOrder < ifThenData.order) maxOrder = ifThenData.order;
    return IfThenCard(ifThenData);
  }
}
