import 'package:sell_history/components/importer.dart';
import 'package:sell_history/models/todo_group.dart';

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

  // 初期化処理
  // TodoGroup：初期Todoデータ作成
  Future<TodoGroup> initTodoGroup() async {
    final TodoGroup initTG = TodoGroup.newTodoGroup();
    initTG.assignUUIDTodoGroup();
    initTG.todoGroupTitle = "default";

    var res = await insertTodoGroup(initTG);
    if (res < 0) {
      return null;
    } else {
      return initTG;
    }
  }

  ///  TodoGroupTable
  static final _todoTable = "todo";
  insertTodo(Todo todo) async {
    todo.uymd = DateTime.now();
    final db = await getDatabase;
    var res = await db.insert(_todoTable, todo.toMap());
    return res;
  }

  readAllTodo(String todoGroupId) async {
    final db = await getDatabase;

    // TOGOグループが未指定の場合は、適当なグループを取得
    //TODO 初期グループの設定処理を考慮する。
    if (todoGroupId == null) {
      TodoGroup targetToGroup;
      var resTodoGroupCount =
          await db.rawQuery('SELECT COUNT(*) FROM ' + _todoGroupTable);
      if (resTodoGroupCount.isEmpty) {
        targetToGroup = await initTodoGroup();
      } else {
        targetToGroup = await readFirstTodoGroup();
      }
      if (targetToGroup != null) {
        todoGroupId = targetToGroup.todoGroupId;
      }
    }
    var res = await db.query(_todoTable,
        where: "todo_group_id = ?", whereArgs: [todoGroupId]);
    // res.map()はListなどの複数値を持っているものについて、()の中の処理をしてList型を返却する
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  updateTodo(Todo todo) async {
    todo.uymd = DateTime.now();
    final db = await getDatabase;
    var res = db.update(_todoTable, todo.toMap(),
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
        .update(_todoTable, checkState, where: "todo_id = ?", whereArgs: [id]);
    return res;
  }

  deleteTodo(String id) async {
    final db = await getDatabase;
    var res =
        await db.delete(_todoTable, where: "todo_id = ?", whereArgs: [id]);
    return res;
  }

  ///  TodoGroupTable
  static final _todoGroupTable = "todo_group";
  insertTodoGroup(TodoGroup todoG) async {
    todoG.uymd = DateTime.now();
    final db = await getDatabase;
    var res = await db.insert(_todoGroupTable, todoG.toMap());
    return res;
  }

  readFirstTodoGroup() async {
    final db = await getDatabase;

    var resTodoGroupFirst =
        await db.query(_todoGroupTable, orderBy: "uymd DESC", limit: 1);
    // res.map()はListなどの複数値を持っているものについて、()の中の処理をしてList型を返却する
    return resTodoGroupFirst.isNotEmpty
        ? resTodoGroupFirst.map((c) => TodoGroup.fromMap(c)).toList()[0]
        : null;
  }

  updateTodoGroup(TodoGroup todoG) async {
    todoG.uymd = DateTime.now();
    final db = await getDatabase;
    var res = db.update(_todoGroupTable, todoG.toMap(),
        where: "todo_group_id = ?", whereArgs: [todoG.todoGroupId]);
    return res;
  }

  deleteTodoGroup(String id) async {
    final db = await getDatabase;
    var res = await db
        .delete(_todoGroupTable, where: "todo_group_id = ?", whereArgs: [id]);
    return res;
  }
}
