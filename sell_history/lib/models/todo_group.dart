import '../components/importer.dart';

class TodoGroup {
  String todoGroupId;
  String todoGroupTitle;
  bool sharedF;
  DateTime uymd;
  String uusr;

  // コンストラクタ
  TodoGroup(
      {this.todoGroupId,
      this.todoGroupTitle,
      this.sharedF,
      this.uymd,
      this.uusr});
  // 名前付きコンストラクタ
  TodoGroup.newTodoGroup() {
    todoGroupTitle = "";
    sharedF = false;
    uymd = DateTime.now();
    uusr = "";
  }

  // SQLiteで取得できたTodoGroup情報(Map)をTodoGroupクラスのインスタンスに変換する
  factory TodoGroup.fromMap(Map<String, dynamic> json) {
    return TodoGroup(
        todoGroupId: json["todo_group_id"],
        todoGroupTitle: json["todo_group_title"],
        sharedF: (json["share_f"] == 1) ? true : false,
        uusr: json["uusr"],
        uymd: (json["uymd"] != null)
            ? DateTime.parse(json["uymd"]).toLocal()
            : null);
  }

  assignUUIDTodoGroup() {
    todoGroupId = Uuid().v4();
  }

  // SQLiteへ登録する際のMap変換
  Map<String, dynamic> toMap() {
    return {
      "todo_group_id": todoGroupId,
      "todo_group_title": todoGroupTitle,
      "share_f": (sharedF) ? 1 : 0,
      "uymd": DbUtility.convDTtSt(uymd),
      "uusr": uusr
    };
  }
}
