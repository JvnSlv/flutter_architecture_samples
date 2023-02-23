import 'dart:async';

import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:uuid/uuid.dart';

import 'todo_service.dart';

class ManageTodoService {
  ManageTodoService(this._todoService, this.uuid);
  final TodoService _todoService;
  final Uuid uuid;

  Future<TodoEntity> createTodo(String task, String note) async {
    if (task.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    final todo =
        TodoEntity(id: uuid.v4(), task: task, note: note, complete: false);
    return await _todoService.addTodo(todo).then((value) => todo);
  }

  Future<TodoEntity> updateTodo(TodoEntity todo) async {
    if (todo.task.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    return await _todoService.updateTodo(todo);
  }
}
