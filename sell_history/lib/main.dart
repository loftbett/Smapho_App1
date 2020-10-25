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
  _moveToEditView() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => TodoEditView()));

  return MaterialApp(
    // これより下部はWidget(アプリ)の形を定義
    home: Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.orange,
        title: Text('Todo'),
        centerTitle: true,
      ),
      body: TodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    ),
  );
}

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        Todo todo = Todo("title $index", DateTime.now(), "memo");
        return Card(
            child: ListTile(
          onTap: () {},
          title: Text('${todo.title}'),
          subtitle: Text('${todo.note}'),
          trailing: Text('${todo.dueDate.toLocal().toString()}'),
          isThreeLine: true,
        ));
      },
    );
  }
}

class Todo {
  String id;
  String title;
  DateTime dueDate;
  String note;

  Todo(this.title, this.dueDate, this.note, [this.id]);

  Todo.newTodo() {
    title = "";
    dueDate = DateTime.now();
    note = "";
  }
}
