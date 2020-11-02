import 'importer.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.appTitle,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      // ダークモード対応
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Provider<TodoBloc>(
          create: (context) => new TodoBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: TodoListView()),
    );
  }
}
