import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  DateTime dueDate;
  String note;

  Todo({@required this.id, this.title, this.dueDate, this.note});

  Todo.newTodo() {
    title = "";
    dueDate = DateTime.now();
    note = "";
  }

  assignUUID() {
    id = Uuid().v4();
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
      id: json["id"],
      title: json["title"],
      dueDate: DateTime.parse(json["dueDate"]).toLocal(),
      note: json["note"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        // sqliteではDate型は直接保存できないため、文字列形式で保存する
        "dueDate": dueDate.toUtc().toIso8601String(),
        "note": note
      };
}
