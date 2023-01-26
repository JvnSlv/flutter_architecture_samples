import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/services/todo_service.dart';

part 'todos_list_manage_bloc.rxb.g.dart';
part 'todos_list_manage_bloc_extensions.dart';

/// A contract class containing all events of the TodosListManageBloC.
abstract class TodosListManageBlocEvents {
  void addTodo(TodoEntity todo);
  void updateTodo(TodoEntity todo);
  void deleteTodo(TodoEntity todo);
}

/// A contract class containing all states of the TodosListManageBloC.
abstract class TodosListManageBlocStates {
  Stream<TodoEntity> get todoDeleted;
  ConnectableStream<void> get todoUpdated;
  ConnectableStream<void> get todoAdded;
}

@RxBloc()
class TodosListManageBloc extends $TodosListManageBloc {
  final TodoService todoService;

  TodosListManageBloc({required this.todoService}) {
    todoUpdated.connect().addTo(_compositeSubscription);
    todoAdded.connect().addTo(_compositeSubscription);
  }
  @override
  ConnectableStream<void> _mapToTodoAddedState() =>
      _$addTodoEvent.doOnData((todo) {
        todoService.addTodo(todo);
      }).publish();

  @override
  Stream<TodoEntity> _mapToTodoDeletedState() =>
      _$deleteTodoEvent.doOnData((todo) {
        todoService.delteTodo(todo);
      });

  @override
  ConnectableStream<void> _mapToTodoUpdatedState() =>
      _$updateTodoEvent.doOnData((todo) {
        todoService.updateTodo(todo.copyWith(complete: !todo.complete));
      }).publish();
}
