import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "To Do",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoListPage(),
    );
  }
}
