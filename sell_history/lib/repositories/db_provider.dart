import 'package:sell_history/components/importer.dart';

class DBProvider {
  // シングルトンに近いインスタンスの作成
  DBProvider._(); // 名前付きコンストラクタ(_がついているのでprivate)
  static final DBProvider db = DBProvider._(); // 自分自身でdbというインスタンスを作成

  static Database _database;

  Future<Database> get getDatabase async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "App.db");

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    // TodoGroupテーブル作成
    await db.execute("CREATE TABLE todo_group("
        "todo_group_id TEXT PRIMARY KEY,"
        "share_f INTEGER,"
        "todo_group_title TEXT,"
        "uymd TEXT,"
        "uusr TEXT"
        ")");

    // Todoテーブル作成
    return await db.execute("CREATE TABLE todo("
        "todo_id TEXT PRIMARY KEY,"
        "todo_group_id TEXT,"
        "title TEXT,"
        "complete INTEGER,"
        "important INTEGER,"
        "note TEXT,"
        "due_date TEXT,"
        "uymd TEXT,"
        "uusr TEXT"
        ")");
  }

  static final _tableName = "todo";
  insertTodo(Todo todo) async {
    todo.uymd = DateTime.now();
    final db = await getDatabase;
    var res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  readAllTodo() async {
    final db = await getDatabase;
    var res = await db.query(_tableName);
    // res.map()はListなどの複数値を持っているものについて、()の中の処理をしてList型を返却する
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  updateTodo(Todo todo) async {
    todo.uymd = DateTime.now();
    final db = await getDatabase;
    var res = db.update(_tableName, todo.toMap(),
        where: "todo_id = ?", whereArgs: [todo.todoId]);
    return res;
  }

  checkedTodo(bool check, String id) async {
    Map<String, dynamic> checkState = {
      "complete": check ? "1" : "0",
      "uymd": DateTime.now().toUtc().toIso8601String()
    };
    final db = await getDatabase;
    var res = db
        .update(_tableName, checkState, where: "todo_id = ?", whereArgs: [id]);
    return res;
  }

  deleteTodo(String id) async {
    final db = await getDatabase;
    var res =
        await db.delete(_tableName, where: "todo_id = ?", whereArgs: [id]);
    return res;
  }
}
