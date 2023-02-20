import 'dart:async';

import 'package:todos_repository_core/todos_repository_core.dart';

import '../enums/options_menu_enum.dart';

class TodoService {
  TodoService(this._repository);
  final ReactiveTodosRepository _repository;

  Stream<List<TodoEntity>> getTodos() => _repository.todos();

  Future<TodoEntity> updateTodo(TodoEntity todoEntity) =>
      _repository.updateTodo(todoEntity).then((value) => todoEntity);

  Future<TodoEntity> deleteTodo(TodoEntity todoEntity) =>
      _repository.deleteTodo([todoEntity.id]).then((value) => todoEntity);

  Future<void> addTodo(TodoEntity todoEntity) =>
      _repository.addNewTodo(todoEntity);

  Future<OptionsMenuEnum> markAllTodos(
      List<TodoEntity> todos, OptionsMenuEnum menu) async {
    await Future.wait(
      todos.map(
        (e) async {
          await updateTodo(
            e.copyWith(complete: menu.value),
          );
        },
      ).toList(),
    );
    if (menu == OptionsMenuEnum.markAllIncomplete) {
      return OptionsMenuEnum.markAllIncomplete;
    } else {
      return OptionsMenuEnum.markAllComplete;
    }
  }

  Future<void> deleteMarkedTodos(List<TodoEntity> todos) async {
    await Future.wait(
      todos.map(
        (e) async {
          await deleteTodo(e);
        },
      ).toList(),
    );
  }
}
