import '../components/importer.dart';

// Todo管理用のBlocクラス
class TodoBloc {
  // 管理している全Todoリスト
  static final List<Todo> sampleTodos = [];

  // BlocのStreamコントローラ
  final _todoController = StreamController<List<Todo>>();

  // 出力Streamのメソッドのgetter(Dartの場合は、get修飾子を使う。)
  Stream<List<Todo>> get todoStream => _todoController.stream;

  // sinkへの流しメソッド
  sinkTodos() async {
    _todoController.sink.add(await DBProvider.db.readAllTodo());
  }

// コンストラクタ
  TodoBloc() {
    // 新規作成時に新規Listをsinkへ流し込み
    sinkTodos();
  }

  dispose() {
    _todoController.close();
  }

  create(Todo todo) {
    todo.assignUUIDTodo();
    DBProvider.db.insertTodo(todo);
    sinkTodos();
  }

  update(Todo todo) {
    DBProvider.db.updateTodo(todo);
    sinkTodos();
  }

  check(bool state, String id) {
    DBProvider.db.checkedTodo(state, id);
    sinkTodos();
  }

  delete(String id) {
    DBProvider.db.deleteTodo(id);
    sinkTodos();
  }
}
