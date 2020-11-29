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
  getTodos() {
    _todoController.sink.add(sampleTodos);
  }

// コンストラクタ
  TodoBloc() {
    // 新規作成時に新規Listをsinkへ流し込み
    getTodos();
  }

  dispose() {
    _todoController.close();
  }

  create(Todo todo) {
    todo.assignUUID();
    sampleTodos.add(todo);

    getTodos();
  }

  update(Todo todo) {
    int _index = sampleTodos.indexWhere((Todo t) => t.id == todo.id);
    if (_index >= 0) {
      sampleTodos[_index] = todo;
      getTodos();
    }
  }

  check(bool state, String id) {
    int _index = sampleTodos.indexWhere((Todo t) => t.id == id);
    if (_index >= 0) {
      sampleTodos[_index].complete = state;
      getTodos();
    }
  }

  delete(String id) {
    int _index = sampleTodos.indexWhere((Todo t) => t.id == id);
    if (_index >= 0) {
      sampleTodos[sampleTodos.length - 1].complete = true;
      sampleTodos.removeAt(_index);
      getTodos();
    }
  }
}
