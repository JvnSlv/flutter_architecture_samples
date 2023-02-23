import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  void toggleTodo(TodoEntity todoEntity, bool isComplete);
  void deleteTodo(TodoEntity todoEntity);
}

/// A contract class containing all states of the TodoDetailsBloC.
abstract class TodoDetailsBlocStates {
  Stream<TodoEntity> get updatedTodo;
  ConnectableStream<void> get deletedTodo;

  Stream<bool> get isLoading;
  Stream<String> get errors;
}

@RxBloc()
class TodoDetailsBloc extends $TodoDetailsBloc {
  final NavigationBlocType navigationBloc;
  final CoordinatorBlocType coordinatorBloc;
  final TodoService todoService;

  TodoDetailsBloc({
    required this.todoService,
    required this.coordinatorBloc,
    required this.navigationBloc,
  }) {
    deletedTodo.connect().addTo(_compositeSubscription);
    coordinatorBloc.states.sendUpdatedTodo
        .bind(_updatedSubject)
        .addTo(_compositeSubscription);
  }

  final _updatedSubject = BehaviorSubject<TodoEntity>();
  @override
  ConnectableStream<void> _mapToDeletedTodoState() =>
      _$deleteTodoEvent.doOnData((todoEntity) {
        coordinatorBloc.events.deleteTodo(todoEntity);
      }).publish();

  @override
  Stream<TodoEntity> _mapToUpdatedTodoState() => Rx.merge([
        _$toggleTodoEvent.switchMap((value) => todoService
            .updateTodo(value.todoEntity.copyWith(complete: value.isComplete))
            .asResultStream()),
        _updatedSubject.asResultStream(),
      ]).setResultStateHandler(this).whereSuccess().shareReplay(maxSize: 1);

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((Exception error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
