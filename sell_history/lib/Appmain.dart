import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SellHistoryMain extends StatefulWidget {
  SellHistoryMain({Key key}) : super(key: key);
  // MainAppの引数あり(key)でのコンストラクタとして右側の処理を定義(リダイレクト)。
  // 右側(super(key*A: key*B))は名前(key*A)付き引数指定のコンストラクタに
  // MainAppの引数部({Key key})のkeyをkey*Bとして渡している形。
  // 今回の呼び出し元(buildメソッドのMainApp()部分)でkeyを指定していないため、keyはnullとなる。
  // 参考:https://note.com/zutai_dekame/n/nabf22f1a3eec
  @override
  _SellHistoryMainState createState() => _SellHistoryMainState();
}

class _SellHistoryMainState extends State<SellHistoryMain> {
  int _currentIndex = 0;
  final items = <BottomNavigationBarItem>[
    _btmItemSet(Icon(Icons.collections), '切替'),
    _btmItemSet(Icon(Icons.add), '追加'),
    _btmItemSet(Icon(Icons.settings), '設定'),
  ];
  final tabs = <Widget>[
    ChangeList(),
    AddItem(),
    Config(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テストアプリ(仮)' + _currentIndex.toString()),
        backgroundColor: Colors.black,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      // IndexedStack：indexで指定したWidgetを表示する
      bottomNavigationBar: _buildBottomNavigator(context),
    );
  }

  // 下部ナビゲーターWidget作成クラス
  Widget _buildBottomNavigator(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      onTap: (index) {
        if (index != _currentIndex) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );
  }
}

class ChangeList extends StatelessWidget {
  const ChangeList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          child: Text('Home'),
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('AddItem'));
  }
}

class Config extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_menuItem('完了したTodoを非表示にする', 'CompViewF', '削除はされません')],
    );
  }
}

// 下部アイコンセットメソッド
BottomNavigationBarItem _btmItemSet(Icon icon, String title) {
  return BottomNavigationBarItem(icon: icon, title: Text(title));
}

/// ListMenuの項目作成用
/// title: 項目名称
/// flagName: 管理フラグ名
/// remarks: 備考
Widget _menuItem(String title, String flagName, String remarks) {
  return GestureDetector(
    child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            border:
                new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ],
        )),
    onTap: () {
      print("onTap called.");
    },
  );
}
