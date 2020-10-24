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
      home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            backgroundColor: Colors.orange,
            title: Text('Form'),
            centerTitle: true,
          ),
          body: DrawerTest()));
}

/*
  ドロワーテスト
*/
class DrawerTest extends StatefulWidget {
  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Drawer')),
      drawer: Drawer(
        child: ListView(
          children: [
            // DrawerHeader(// 通常のHeader
            //   child: Text('Header'),
            //   decoration: BoxDecoration(color: Colors.blue),
            //   margin: EdgeInsets.all(5.0),
            //   padding: EdgeInsets.all(5.0),
            // ),
            UserAccountsDrawerHeader(
              // ユーザアカウントの情報を記載する用
              accountName: Text('username'),
              currentAccountPicture: Icon(Icons.supervised_user_circle),
              otherAccountsPictures: [
                Icon(Icons.supervised_user_circle),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/'),
                ),
              ],
            ),
            ListTile(
              title: Text('tile1'),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text('tile2'),
              trailing: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}

/*
  タイトルスライドリストテストクラス
*/
class SlideHeaderListTest extends StatefulWidget {
  @override
  _SlideHeaderListTestState createState() => _SlideHeaderListTestState();
}

class _SlideHeaderListTestState extends State<SlideHeaderListTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            floating: true, //リストの先頭まで戻らなくても上スクロールでタイトルを出すかどうか ※trueで良さそう
            pinned: true, // タイトル部を1行分残すかどうか　※その時々
            snap:
                true, // スクロールにより中途半端に表示されなくなる。floatingをtrueにする必要あり.　※trueで良さそう
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
            )),
        SliverFixedExtentList(
          itemExtent: 200.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child:
                    Text('list item $index', style: TextStyle(fontSize: 30.0)));
          }, childCount: 10),
        )
      ],
    ));
  }
}

/*
  タイトルスライドグリッドテストクラス
*/
class SlideTitleGridTest extends StatefulWidget {
  @override
  _SlideTitleGridTestState createState() => _SlideTitleGridTestState();
}

class _SlideTitleGridTestState extends State<SlideTitleGridTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(title: Text('Title')),
        ),
        SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('List index $index'));
            }),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                // グリッドの横配置数を画面サイズをもとに決定してくれる
                // SliverGridDelegateWithFixedCrossAxisExtentは固定
                maxCrossAxisExtent: 100.0,
                //crossAxisCount: 10, // fixedの場合の配置数
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0))
      ],
    ));
  }
}

/*
  下部ボタンのテストクラス
*/
class AppButtonTest extends StatefulWidget {
  @override
  _AppButtonTestState createState() => _AppButtonTestState();
}

class _AppButtonTestState extends State<AppButtonTest> {
  int _currentIndex = 0;
  final _pageWidget = [
    PageWidget(color: Colors.white, title: 'Home'),
    PageWidget(color: Colors.blue, title: 'album'),
    PageWidget(color: Colors.orange, title: 'chat'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              title: Text('album'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('chat')),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType
            .fixed, // shiftingにした場合はBarItemのバックグラウンドカラーを設定する
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index);
}

class PageWidget extends StatelessWidget {
  final Color color;
  final String title;

  PageWidget({Key key, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: color, child: Center(child: Text(title)));
  }
}

/*
  Tabバーテストクラス
*/
class TabBarTest extends StatefulWidget {
  @override
  _TabBarTestState createState() => _TabBarTestState();
}

class _TabBarTestState extends State<TabBarTest>
    with SingleTickerProviderStateMixin {
  final _tab = <Tab>[
    Tab(text: 'Car', icon: Icon(Icons.directions_car)),
    Tab(text: 'Bicycle', icon: Icon(Icons.directions_bike)),
    Tab(text: 'Boat', icon: Icon(Icons.directions_boat)),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tab.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: TabBar(
        tabs: _tab,
        controller: _tabController,
      )),
      body: TabBarView(
        controller: _tabController,
        children: [
          TabPage(title: 'Car', icon: Icons.directions_car),
          TabPage(title: 'Car', icon: Icons.directions_car),
          TabPage(title: 'Boat', icon: Icons.directions_boat),
        ],
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final IconData icon;
  final String title;

  TabPage({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle tS = Theme.of(context).textTheme.display1;
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 64.0, color: tS.color),
        Text(title, style: tS),
      ],
    ));
  }
}

/*
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

/*
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

/*
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

/*
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

/*
　スイッチテスト
*/
class SwitchTest extends StatefulWidget {
  @override
  _SwitchTestState createState() => _SwitchTestState();
}

class _SwitchTestState extends State<SwitchTest> {
  bool _active = false;

  void _hundleSwitch(bool e) => setState(() => _active = e);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.thumb_up,
              color: _active ? Colors.red : Colors.grey,
              size: 100.0,
            ),
            Switch(
              value: _active,
              onChanged: _hundleSwitch,
            )
          ],
        ));
  }
}

/*
  スライダーテスト
*/
class SliderTest extends StatefulWidget {
  @override
  _SliderTestState createState() => _SliderTestState();
}

class _SliderTestState extends State<SliderTest> {
  double _value = 0.0;
  double _startValue = 0.0;
  double _endValue = 0.0;

  void _hundleSliderValue(double e) => setState(() => _value = e);
  void _hundleSliderStartValue(double e) => setState(() => _startValue = e);
  void _hundleSliderEndValue(double e) => setState(() => _endValue = e);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Center(child: Text('現在値: ${_value}')),
            Center(child: Text('開始時の値: ${_startValue}')),
            Center(child: Text('終了時の値: ${_endValue}')),
            Slider(
              label: '${_value}',
              min: 0,
              max: 10,
              value: _value,
              activeColor: Colors.orange,
              inactiveColor: Colors.blueAccent,
              divisions: 10,
              onChanged: _hundleSliderValue,
              onChangeStart: _hundleSliderStartValue,
              onChangeEnd: _hundleSliderEndValue,
            )
          ],
        ));
  }
}

/*
　日付選択のテストクラス
*/
class DatePickerTest extends StatefulWidget {
  @override
  _DatePickerTestState createState() => _DatePickerTestState();
}

class _DatePickerTestState extends State<DatePickerTest> {
  TimeOfDay _date = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _date,
    );
    if (picked != null)
      setState(() {
        _date = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Center(child: Text("${_date}")),
            RaisedButton(
                onPressed: () => _selectDate(context), child: Text('時間選択'))
          ],
        ));
  }
}

/*
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
