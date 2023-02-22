import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

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

  Stream<bool> get isLoading;
  Stream<String> get errors;
}

@RxBloc()
class TodosListManageBloc extends $TodosListManageBloc {
  final TodoService todoService;
  final CoordinatorBlocType coordinatorBloc;
  final NavigationBlocType navigationBloc;
  TodosListManageBloc({
    required this.navigationBloc,
    required this.coordinatorBloc,
    required this.todoService,
  }) {
    todoUpdated.connect().addTo(_compositeSubscription);
    todoAdded.connect().addTo(_compositeSubscription);
    coordinatorBloc.states.todoDeleted
        .bind(_$deleteTodoEvent)
        .addTo(_compositeSubscription);
  }

  @override
  ConnectableStream<void> _mapToTodoAddedState() => _$addTodoEvent
      .switchMap((todo) => todoService.addTodo(todo).asResultStream())
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  Stream<TodoEntity> _mapToTodoDeletedState() => _$deleteTodoEvent
      .switchMap((todo) => todoService.deleteTodo(todo).asResultStream())
      .doOnData(
        (value) => navigationBloc.events.navigate(
          const NavigationParams(navigationEnum: NavigationEnum.list),
        ),
      )
      .setResultStateHandler(this)
      .whereSuccess();

  @override
  ConnectableStream<void> _mapToTodoUpdatedState() => _$updateTodoEvent
      .switchMap((todo) => todoService
          .updateTodo(todo.copyWith(complete: !todo.complete))
          .asResultStream())
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((Exception error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
