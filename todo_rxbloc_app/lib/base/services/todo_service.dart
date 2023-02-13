import 'dart:async';

import 'package:todos_repository_core/todos_repository_core.dart';

import '../enums/filter_enum.dart';
import '../enums/options_menu_enum.dart';

class TodoService {
  TodoService(this._repository);
  final ReactiveTodosRepository _repository;

  Stream<List<TodoEntity>> getTodos(FilterEnum filterValue) {
    switch (filterValue) {
      case FilterEnum.showAll:
        return _repository.todos();
      case FilterEnum.showActive:
      case FilterEnum.showCompleted:
        return _repository.todos().map(
              (event) => event
                  .where((element) => element.complete == filterValue.value)
                  .toList(),
            );
      default:
        return _repository.todos();
    }
  }

  Future<TodoEntity> updateTodo(TodoEntity todoEntity) =>
      _repository.updateTodo(todoEntity).then((value) => todoEntity);

  Future<TodoEntity> delteTodo(TodoEntity todoEntity) =>
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
          await delteTodo(e);
        },
      ).toList(),
    );
  }
}
