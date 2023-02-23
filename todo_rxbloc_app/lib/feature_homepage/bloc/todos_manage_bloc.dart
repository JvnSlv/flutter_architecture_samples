import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/enums/filter_enum.dart';
import '../../base/enums/options_menu_enum.dart';
import '../../base/services/todo_service.dart';

part 'todos_manage_bloc.rxb.g.dart';

/// A contract class containing all events of the TodosManageBloC.
abstract class TodosManageBlocEvents {
  void fetchData();

  void getTodosList();
  @RxBlocEvent(
      type: RxBlocEventType.behaviour, seed: OptionsMenuEnum.markAllComplete)
  void markAll(OptionsMenuEnum option);
  void deleteMarked();
}

/// A contract class containing all states of the TodosManageBloC.
abstract class TodosManageBlocStates {
  Stream<bool> get isLoading;
  Stream<String> get errors;

  Stream<ReturnValues> get markTodosComplete;
  ConnectableStream<void> get deleteMarkedTodos;
  ConnectableStream<List<TodoEntity>> get todosList;
}

@RxBloc()
class TodosManageBloc extends $TodosManageBloc {
  final TodoService todoService;

  TodosManageBloc(this.todoService) {
    deleteMarkedTodos.connect().addTo(_compositeSubscription);
    todosList.connect().addTo(_compositeSubscription);
  }
  @override
  ConnectableStream<void> _mapToDeleteMarkedTodosState() => _$deleteMarkedEvent
      .withLatestFrom<List<TodoEntity>, List<TodoEntity>>(
          todosList, (_, todos) => todos)
      .switchMap((value) => todoService
          .deleteMarkedTodos(
              value.where((element) => element.complete == true).toList())
          .asResultStream())
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  ConnectableStream<List<TodoEntity>> _mapToTodosListState() =>
      _$getTodosListEvent
          .startWith(null)
          .switchMap((value) =>
              todoService.getTodos(FilterEnum.showAll).asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publishReplay(maxSize: 1);

  @override
  Stream<ReturnValues> _mapToMarkTodosCompleteState() => Rx.merge([
        Rx.combineLatest2<OptionsMenuEnum, List<TodoEntity>, ReturnValues>(
            _$markAllEvent,
            todosList,
            (menu, todos) => ReturnValues(todos, menu)).switchMap((value) {
          if (value.todos.any((element) => element.complete == false)) {
            return Stream.value(
                ReturnValues(value.todos, OptionsMenuEnum.markAllIncomplete));
          } else {
            return Stream.value(
                ReturnValues(value.todos, OptionsMenuEnum.markAllComplete));
          }
        }).mapToResult(),
        _$markAllEvent
            .withLatestFrom2<OptionsMenuEnum, List<TodoEntity>, ReturnValues>(
                _$markAllEvent,
                todosList,
                (menu, _, todos) => ReturnValues(todos, menu))
            .switchMap(
              (value) => todoService
                  .markAllTodos(value.todos, value.menu)
                  .asStream()
                  .map((event) => ReturnValues(value.todos, event))
                  .asResultStream(),
            )
      ]).setResultStateHandler(this).whereSuccess();

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}

class ReturnValues {
  final List<TodoEntity> todos;
  final OptionsMenuEnum menu;

  ReturnValues(this.todos, this.menu);
}
