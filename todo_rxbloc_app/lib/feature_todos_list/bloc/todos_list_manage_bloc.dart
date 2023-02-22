import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/filter_enum.dart';
import '../../base/enums/options_menu_enum.dart';
import '../../base/models/navigation_parameters.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todos_list_manage_bloc.rxb.g.dart';
part 'todos_list_manage_bloc_extensions.dart';

/// A contract class containing all events of the TodosListManageBloC.
abstract class TodosListManageBlocEvents {
  void addTodo(TodoEntity todo);
  void updateTodo(TodoEntity todo);
  void deleteTodo(TodoEntity todo);
  void getTodosList();
  @RxBlocEvent(
      type: RxBlocEventType.behaviour, seed: OptionsMenuEnum.markAllComplete)
  void markAll(OptionsMenuEnum option);
  void deleteMarked();
}

/// A contract class containing all states of the TodosListManageBloC.
abstract class TodosListManageBlocStates {
  Stream<TodoEntity> get todoDeleted;
  ConnectableStream<void> get todoUpdated;
  ConnectableStream<void> get todoAdded;

  ConnectableStream<List<TodoEntity>> get todosList;
  Stream<OptionsMenuEnum> get markTodosComplete;
  ConnectableStream<void> get deleteMarkedTodos;
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
  ConnectableStream<void> _mapToDeleteMarkedTodosState() => _$deleteMarkedEvent
      .withLatestFrom<List<TodoEntity>, List<TodoEntity>>(
          todosList, (_, todos) => todos)
      .switchMap((value) => todoService
          .deleteMarkedTodos(
              value.where((element) => element.complete == true).toList())
          .asResultStream()
          .setResultStateHandler(this)
          .whereSuccess())
      .publish();

  @override
  ConnectableStream<List<TodoEntity>> _mapToTodosListState() =>
      _$getTodosListEvent
          .startWith(null)
          .switchMap((value) => todoService
              .getTodos(FilterEnum.showAll)
              .asResultStream()
              .setResultStateHandler(this)
              .whereSuccess())
          .publishReplay(maxSize: 1);

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

  @override
  Stream<OptionsMenuEnum> _mapToMarkTodosCompleteState() => Rx.merge([
        Rx.combineLatest2<OptionsMenuEnum, List<TodoEntity>, OptionsMenuEnum>(
            _$markAllEvent, todosList, (menu, todos) {
          if (todos.any((element) => element.complete == false)) {
            return OptionsMenuEnum.markAllIncomplete;
          } else {
            return OptionsMenuEnum.markAllComplete;
          }
        }),
        _$markAllEvent
            .withLatestFrom2<OptionsMenuEnum, List<TodoEntity>, ReturnValues>(
                _$markAllEvent,
                todosList,
                (menu, _, todos) => ReturnValues(todos, menu))
            .switchMap(
              (value) => todoService
                  .markAllTodos(value.todos, value.menu)
                  .asResultStream()
                  .setResultStateHandler(this)
                  .whereSuccess(),
            )
      ]);
}

class ReturnValues {
  final List<TodoEntity> todos;
  final OptionsMenuEnum menu;

  ReturnValues(this.todos, this.menu);
}
