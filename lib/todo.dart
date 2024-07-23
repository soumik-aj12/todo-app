// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_app/model.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();
  List<TodoType> _todos = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  final _api = "http://192.168.0.104:8080/api/todos";

  Future<void> _fetchTodos() async {
    final res = await http.get(Uri.parse(_api));
    log(res.body.toString());
    log(res.body[0].toString());
    if (res.statusCode == 200) {
      List<TodoType> data = (json.decode(res.body) as List).map(
            (e) => TodoType.fromMap(e),
          ).toList();
      setState(() {
        _todos.addAll(data);
        _controller.clear();
      });
    }
  }

  Future<void> _addTodo() async {
    final res = await http.post(
      Uri.parse(_api),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': _controller.text}),
    );
    print(json.encode(res.body));
    if (res.statusCode == 200) {
        TodoType newTodo = TodoType.fromJson(res.body);
      setState(() {
        _todos.add(newTodo);
        _controller.clear();
      });
    }
  }

  Future<void> _deleteTodo(int id) async {
    final res = await http.delete(Uri.parse("$_api/$id"));
    if (res.statusCode == 200) {
      setState(() {
        _todos.removeWhere((todo) => todo.id == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: " Add a todo:-")),
          ),
          ElevatedButton(onPressed: _addTodo, child: Text("Add")),
          Expanded(
              child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    final todo = _todos[index];
                    print(todo);
                    return ListTile(
                      title: Text(todo.title),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTodo(todo.id),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
