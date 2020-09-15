// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());
/* ファストアローでの記法　
  main() {
    runApp(MyApp());
  }; と同義 */

class MyApp extends StatelessWidget {
  // StatelessWidgetはFlutterでよく出会うクラス(自身で状態を持たないクラス)
  @override
  Widget build(BuildContext context) {
    // buildメソッドはWidgetの肝? Widgetクラスには必ず持つ。Widgetを返す。
    return MaterialApp(
      // これより下部はWidget(アプリ)の形を定義
      title: 'Welcome to Flutter TEST', // アプリタイトル:
      home: RandomWords(),
    );
  }
}

// stfulと打つと雛形を作ってくれる
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random List')),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // itemBuilderがListView.builderを使った際にListの項目を作り出すようの
          // 処理記述部
          if (i.isOdd) return Divider(color: Colors.yellow);
          // Divider：横線

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
