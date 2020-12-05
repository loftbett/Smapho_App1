import '../components/importer.dart';

class Todo {
  String todoId;
  String todoGroupId;
  String title;
  bool complete;
  bool important;
  String note;
  DateTime dueDate;
  DateTime uymd;
  String uusr;

  Todo(
      {this.todoId,
      this.todoGroupId,
      @required this.title,
      @required this.dueDate,
      @required this.note,
      this.complete,
      this.important,
      this.uymd,
      this.uusr});
  Todo.newTodo() {
    title = "";
    todoGroupId = "";
    dueDate = DateTime.now();
    note = "";
    complete = false;
    important = false;
    uymd = DateTime.now();
    uusr = "";
  }

  // SQLiteから取得できるTodo情報(Map<String,dynamic>)をTodoクラスを返却する
  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
      todoId: json["todo_id"],
      todoGroupId: json["todo_group_id"],
      title: json["title"],
      // DateTime型は文字列で保存されているため、DateTime型に変換し直す
      dueDate: DateTime.parse(json["due_date"]).toLocal(),
      note: json["note"],
      complete: (json["complete"] == 1) ? true : false,
      important: (json["important"] == 1) ? true : false,
      uymd: DateTime.parse(json["uymd"]).toLocal(),
      uusr: json["uusr"]);

  assignUUIDTodo() {
    todoId = Uuid().v4();
  }

  assignUUIDTodoGroup() {
    todoGroupId = Uuid().v4();
  }

  // SQLiteへ登録する際のMap変換
  Map<String, dynamic> toMap() => {
        "todo_id": todoId,
        "todo_group_id": todoGroupId,
        "title": title,
        // SQLiteでの日付補完はUTC時間(日本時間-9時間)で行う
        "due_date": dueDate.toUtc().toIso8601String(),
        "note": note,
        "complete": complete ? "1" : "0",
        "important": important ? "1" : "0",
        "uymd": uymd.toUtc().toIso8601String()
      };
}
