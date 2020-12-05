import 'package:sell_history/components/importer.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<TodoBloc>(context, listen: false);
    StyleBase styleBase = new StyleBase();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: Text(ConstText.todoListView)),
        body: StreamBuilder<List<Todo>>(
          stream: _bloc.todoStream,
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo todo = snapshot.data[index];
                  bool checked = todo.complete;
                  return Dismissible(
                      // スワイプ処理を備えたクラス
                      key: Key(todo.todoId),
                      background: _backgroundOfDismissible(),
                      secondaryBackground: _secondaryBackgroundOfDismissible(),
                      onDismissed: (direction) {
                        _bloc.delete(todo.todoId);
                      },
                      child: Card(
                          child: ListTile(
                              onTap: () {
                                _moveToEditView(context, _bloc, todo);
                              },
                              title: Text("${todo.title}",
                                  style: styleBase.todoMainText(
                                      todo.complete, todo.important)),
                              subtitle: Text("${todo.note}",
                                  style: styleBase.todoSubText(
                                      todo.complete, todo.important)),
                              trailing: Text(
                                  "${ConstText.dateFormatYMDHM.format(todo.dueDate.toLocal())}"),
                              isThreeLine: true,
                              leading: Checkbox(
                                value: checked,
                                onChanged: (b) {
                                  _bloc.check(b, todo.todoId);
                                },
                              )),
                          color: todo.complete ? Colors.grey : Colors.white));
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _moveToCreateView(context, _bloc);
          },
          child: Icon(Icons.add, size: 40),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: size.height * 0.05,
              child: IconButton(
                icon: Icon(Icons.sync),
                onPressed: () {
                  print('pushed');
                },
              )),
        ));
  }

  _moveToEditView(
          BuildContext context, TodoBloc bloc, Todo todo) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodoEditView(todoBloc: bloc, todo: todo)));

  _moveToCreateView(BuildContext context, TodoBloc bloc) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TodoEditView(todoBloc: bloc, todo: Todo.newTodo())));

  _backgroundOfDismissible() => Container(
      alignment: Alignment.centerLeft,
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Icon(Icons.done, color: Colors.white),
      ));

  _secondaryBackgroundOfDismissible() => Container(
      alignment: Alignment.centerRight,
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Icon(Icons.done, color: Colors.white),
      ));
}
