import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todos_list_bloc.rxb.g.dart';
part 'todos_list_bloc_extensions.dart';

abstract class TodosListBlocEvents {
  void fetchTodosList();
  void updateTodo(TodoEntity todo);
  void deleteTodo(TodoEntity todo);
  void addTodo(TodoEntity todo);
  void navigateToPage(NavigationParametars navigationParametars);
}

abstract class TodosListBlocStates {
  Stream<Result<List<TodoEntity>>> get todosList;
  ConnectableStream<void> get updatedTodo;
  ConnectableStream<void> get addedTodo;
  Stream<TodoEntity> get isTodoDeleted;
  Stream<NavigationParametars> get navigate;
}

@RxBloc()
class TodosListBloc extends $TodosListBloc {
  TodosListBloc({
    required this.navigationBloc,
    required this.todoService,
  }) {
    addedTodo.connect().addTo(_compositeSubscription);
    updatedTodo.connect().addTo(_compositeSubscription);
  }
  final NavigationBlocType navigationBloc;
  final TodoService todoService;

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodosListState() =>
      _$fetchTodosListEvent
          .startWith(null)
          .switchMap(
            (value) => todoService.getTodos(),
          )
          .distinct()
          .shareReplay(maxSize: 1)
          .asResultStream();

  @override
  Stream<TodoEntity> _mapToIsTodoDeletedState() =>
      _$deleteTodoEvent.switchMap((value) async* {
        await todoService.delteTodo(value);
        yield value;
      });

  @override
  Stream<NavigationParametars> _mapToNavigateState() =>
      _$navigateToPageEvent.doOnData((event) {
        navigationBloc.events.navigate(event);
      });

  @override
  ConnectableStream<void> _mapToUpdatedTodoState() => _$updateTodoEvent
      .switchMap(
        (value) => todoService
            .updateTodo(
              value.copyWith(complete: !value.complete),
            )
            .asResultStream(),
      )
      .publish();

  @override
  ConnectableStream<void> _mapToAddedTodoState() =>
      _$addTodoEvent.switchMap((value) async* {
        todoService.addTodo(value).asResultStream();
      }).publish();
}
