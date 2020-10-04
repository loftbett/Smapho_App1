// Use of this source code is governed by a BSD-style license that can be
// Copyright 2018 The Flutter team. All rights reserved.
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        home:
            Scaffold(appBar: AppBar(title: Text('Flat')), body: OnOffButton()));
  }
}

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
