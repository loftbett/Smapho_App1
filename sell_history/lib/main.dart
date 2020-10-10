// Use of this source code is governed by a BSD-style license that can be
// Copyright 2018 The Flutter team. All rights reserved.
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// localclass
import 'Appmain.dart';

//void main() => runApp(MyApp());
void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // これより下部はWidget(アプリ)の形を定義
        home: Scaffold(appBar: AppBar(title: Text('Form')), body: RadioTest()));
    // 試作アプリを動かす場合は下記
    // home: SellHistoryMain());
  }
}

/**
 * ボタンテストクラス
 */
class OnOffButton extends StatefulWidget {
  @override
  _OnOffButtonState createState() => _OnOffButtonState();
}

class _OnOffButtonState extends State<OnOffButton> {
  bool _onoffState = true;
  String _buttonText = 'test';
  int _count = 0;

  void _hundleTap(String s) {
    setState(() {
      _count = int.parse(s);
      _onoffState = !_onoffState;
      _buttonText = _onoffState ? 'ON' : 'OFF';
    });
  }

  @override
  Widget build(BuildContext context) {
    Color onoffColor = _onoffState ? Colors.red : Colors.grey;
    return Container(
        padding: EdgeInsets.all(50.0),
        child: Column(children: <Widget>[
          Text("$_count",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500)),
          PopupMenuButton<int>(
              onSelected: (int s) => {
                    setState(() {
                      _count = s * 10;
                    })
                  }, //_hundleTap,
              // itemBuilderのプロパティとして、BuilderContextを引数として
              // PopupMenuEntry<String>の型で、[]配列の中身を返している。
              //
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(value: 1, child: Text('1')),
                    const PopupMenuItem<int>(value: 2, child: Text('2')),
                    const PopupMenuItem<int>(value: 3, child: Text('3')),
                    const PopupMenuItem<int>(value: 4, child: Text('4')),
                  ])
        ]));
  }
}

/**
 * テキスト入力テストクラス
 */
class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  String _text = "";
  bool _enableF = true;
  var _textController = TextEditingController();

  void _handleText(String e) {
    setState(() {
      _text = e;
      if (e.length > 9) {
        _enableF = false;
      }
    }); // setStateには関数を引数に渡す
  }

  void _resetText() {
    setState(() {
      this._text = "";
      _enableF = true;
      _textController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Text(
              "$_text",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            ),
            TextField(
              enabled: _enableF,
              maxLength: 10,
              maxLengthEnforced: false,
              style: TextStyle(color: Colors.red),
              obscureText: false,
              maxLines: 3,
              onChanged: _handleText,
              controller: _textController,
            ),
            FlatButton(
                onPressed: _resetText,
                color: Colors.orange,
                child: Text('リセット'))
          ],
        ));
  }
}

/**
 * チェンジボックステスト
 * Todoリストに利用！
 * ListのどれがタップされたかはControllerを追加して認識する？
 */
class CheckboxTest extends StatefulWidget {
  @override
  _CheckboxTestState createState() => _CheckboxTestState();
}

class _CheckboxTestState extends State<CheckboxTest> {
  bool _flg = false;
  bool _flg2 = false;

  void _handleCheck(bool e) {
    setState(() {
      _flg = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CheckboxListTile(
              activeColor: Colors.red,
              title: Text('チェックボックステスト'),
              subtitle: Text('サブタイトル '),
              secondary: Icon(
                Icons.thumb_up,
                color: _flg ? Colors.orange[900] : Colors.grey[500],
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: _flg,
              onChanged: _handleCheck,
            ),
            CheckboxListTile(
              activeColor: Colors.red,
              title: Text('チェックボックステスト'),
              subtitle: Text('サブタイトル '),
              secondary: Icon(
                Icons.thumb_up,
                color: _flg ? Colors.orange[900] : Colors.grey[500],
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: _flg,
              onChanged: _handleCheck,
            )
          ],
        ));
  }
}

/**
 * Radioテスト
 */
class RadioTest extends StatefulWidget {
  @override
  _RadioTestState createState() => _RadioTestState();
}

class _RadioTestState extends State<RadioTest> {
  String _type = '';

  void _hundleRadio(String e) => setState(() {
        _type = e;
      });

  IconData _changeIcon(String e) {
    IconData icon = null;
    switch (e) {
      case 'thumb_up':
        icon = Icons.thumb_up;
        break;
      case 'favorite':
        icon = Icons.favorite;
        break;
      default:
        icon = null;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Center(
                child: Icon(
              _changeIcon(_type),
              color: Colors.orange,
              size: 100.0,
            )),
            ListTile(
              title: Text('radio1'),
              trailing: Radio(
                activeColor: Colors.blue,
                value: 'thumb_up',
                groupValue: _type,
                onChanged: _hundleRadio,
              ),
            ),
            Radio(
              activeColor: Colors.blue,
              value: 'favorite',
              groupValue: _type,
              onChanged: _hundleRadio,
            )
          ],
        ));
  }
}
/**
 * ダイアログテストクラス
 */
// enum Answer { YES, NO }

// class _MainPageState extends State<MainPage> {
//   String _value = "";

//   void _setValue(String value) => setState(() => _value = value);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(32.0),
//         child: Center(
//             child: Column(children: <Widget>[
//           Text(
//             _value,
//             style: TextStyle(
//               fontSize: 50.0,
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           RaisedButton(
//             onPressed: () {
//               openDialog(context);
//             },
//             child: Text('ダイアログを開く'),
//           )
//         ])));
//   }

//   void openDialog(BuildContext context) {
//     showDialog<Answer>(
//       context: context,
//       )
//   }
//}
