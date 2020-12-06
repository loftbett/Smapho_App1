import '../importer.dart';

class ChangeTodo extends ChangeNotifier {
  Todo _newTodo;

  void value(Todo todo) {
    _newTodo = todo;
  }

  Todo get newTodo => _newTodo;

  void execChange() {
    notifyListeners();
  }
}

class TodoEditView extends StatelessWidget {
  final TodoBloc todoBloc;
  final Todo todo;
  final ChangeTodo _newTodo = ChangeTodo();

  TodoEditView({Key key, @required this.todoBloc, @required this.todo}) {
    // Dartでは参照渡しが行われるため、todoをそのまま編集してしまうと、
    // 更新せずにリスト画面に戻ったときも値が更新されてしまうため、
    // 新しいインスタンスを作る
    _newTodo.value(todo);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeTodo>.value(
        value: _newTodo,
        child: Scaffold(
            appBar: AppBar(title: Text(ConstText.todoEditView)),
            body: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  _titleTextFormField(),
                  ImportantCheckField(),
                  _dueDateTimeFormField(),
                  _noteTextFormField(),
                  _confirmButton(context)
                ],
              ),
            )));
  }

  // タイトル入力Widget
  Widget _titleTextFormField() => TextFormField(
        decoration: InputDecoration(labelText: "タイトル"),
        initialValue: _newTodo.newTodo.title,
        onChanged: _setTitle,
      );

  void _setTitle(String title) {
    _newTodo.newTodo.title = title;
  }

  // 期日設定Widget
  // ↓ https://pub.dev/packages/datetime_picker_formfield のサンプルから引用
  Widget _dueDateTimeFormField() => DateTimeField(
      format: ConstText.dateFormatYMD,
      decoration: InputDecoration(labelText: "期限"),
      initialValue: _newTodo.newTodo.dueDate,
      onChanged: _setDueDate,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      });

  void _setDueDate(DateTime dt) {
    _newTodo.newTodo.dueDate = dt;
  }

  Widget _noteTextFormField() => TextFormField(
        decoration: InputDecoration(labelText: "メモ"),
        initialValue: _newTodo.newTodo.note,
        maxLines: 3,
        onChanged: _setNote,
      );

  void _setNote(String note) {
    _newTodo.newTodo.note = note;
  }

  Widget _confirmButton(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 20.0),
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.5,
        child: RaisedButton.icon(
          icon: Icon(
            Icons.tag_faces,
            color: Colors.white,
          ),
          label: Text("追加"),
          onPressed: () {
            if (_newTodo.newTodo.todoId == null) {
              todoBloc.create(_newTodo.newTodo);
            } else {
              todoBloc.update(_newTodo.newTodo);
            }

            Navigator.of(context).pop();
          },
          shape: StadiumBorder(),
          color: Colors.green,
          textColor: Colors.white,
        ),
      );
}

class ImportantCheckField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChangeTodo _todo = Provider.of<ChangeTodo>(context);
    return SwitchListTile(
      title: Text("重要"),
      value: _todo.newTodo.important,
      onChanged: (b) {
        _todo.newTodo.important = b;
        _todo.execChange();
      },
    );
  }
}
