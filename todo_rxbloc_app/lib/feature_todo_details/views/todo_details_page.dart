import 'package:flutter/material.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({super.key, required this.todo, required this.id});
  final TodoEntity todo;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(todo.id)),
    );
  }
}
