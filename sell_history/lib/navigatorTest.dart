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
//    return sellAppMain(context); // 試作アプリ実行用
    return testMain(context); // テストアプリ実行用
  }
}

Widget testMain(BuildContext context) {
  return MaterialApp(
    // これより下部はWidget(アプリ)の形を定義
    home: MainPage(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MainPage(),
      '/subpage1': (BuildContext context) => new SubPage(page: Pages.PAGE1),
      '/subpage2': (BuildContext context) => new SubPage(page: Pages.PAGE2),
      '/subpage3': (BuildContext context) => new SubPage(page: Pages.PAGE3),
    },
  );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Navigator'),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                Text('Main'),
                RaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed("/subpage1"),
                  child: Text('Subページへ'),
                )
              ],
            ),
          ),
        ));
  }
}

enum Pages { PAGE1, PAGE2, PAGE3 }

class SubPage extends StatelessWidget {
  final Pages page;
  SubPage({this.page});

  @override
  Widget build(BuildContext context) {
    List<Widget> widget;
    switch (page) {
      case Pages.PAGE1:
        widget = <Widget>[
          Text('page1'),
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed('/subpage2'),
            child: Text('次へ'),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('戻る'),
          ),
        ];
        break;
      case Pages.PAGE2:
        widget = <Widget>[
          Text('page2'),
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed('/subpage3'),
            child: Text('次へ'),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('戻る'),
          ),
        ];
        break;
      case Pages.PAGE3:
        widget = <Widget>[
          Text('page3'),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('戻る'),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (_) => false),
            child: Text('ホームへ'),
          ),
        ];
        break;
      default:
        break;
    }
    return Scaffold(
        appBar: AppBar(title: Text('Navigator')),
        body: Container(
            child: Center(
          child: Column(
            children: widget,
          ),
        )));
  }
}
