import 'package:todos_repository_core/todos_repository_core.dart';

class TodoService {
  TodoService(this._repository);
  final ReactiveTodosRepository _repository;

  Stream<List<TodoEntity>> getTodos() => _repository.todos();

  Future<void> updateTodo(TodoEntity todo) => _repository.updateTodo(todo);

  Future<void> delteTodo(TodoEntity todoEntity) =>
      _repository.deleteTodo([todoEntity.id]);

  Future<void> addTodo(TodoEntity todoEntity) =>
      _repository.addNewTodo(todoEntity);
}
