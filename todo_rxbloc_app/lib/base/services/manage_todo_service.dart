import 'dart:async';

import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:uuid/uuid.dart';

import 'todo_service.dart';

class ManageTodoService {
  ManageTodoService(this._todoService, this.uuid);
  final TodoService _todoService;
  final Uuid uuid;

  //Change
  Future<void> createTodo(String task, String note) async =>
      await _todoService.addTodo(
        TodoEntity(
          id: uuid.v4(),
          task: task,
          note: note,
          complete: false,
        ),
      );

  Future<void> updateTodo(TodoEntity todo) async =>
      await _todoService.updateTodo(todo);
}
