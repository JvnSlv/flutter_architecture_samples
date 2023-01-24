import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/services/todo_service.dart';

part 'stats_bloc.rxb.g.dart';
part 'stats_bloc_extensions.dart';

/// A contract class containing all events of the StatsBloC.
abstract class StatsBlocEvents {
  void fetchTodos();
}

/// A contract class containing all states of the StatsBloC.
abstract class StatsBlocStates {
  Stream<Result<List<TodoEntity>>> get getTodoList;
}

@RxBloc()
class StatsBloc extends $StatsBloc {
  final TodoService todoService;

  StatsBloc({required this.todoService});
  @override
  Stream<Result<List<TodoEntity>>> _mapToGetTodoListState() => _$fetchTodosEvent
      .startWith(null)
      .switchMap((value) => todoService.getTodos())
      .shareReplay()
      .asResultStream();
}
