import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/enums/filter_enum.dart';
import '../../base/services/todo_service.dart';
import '../models/todo_stats.dart';

part 'stats_bloc.rxb.g.dart';
part 'stats_bloc_extensions.dart';

/// A contract class containing all events of the StatsBloC.
abstract class StatsBlocEvents {
  void fetchTodos();
}

/// A contract class containing all states of the StatsBloC.
abstract class StatsBlocStates {
  Stream<Result<TodoStats>> get getTodoList;
}

@RxBloc()
class StatsBloc extends $StatsBloc {
  final TodoService todoService;

  StatsBloc({required this.todoService});
  @override
  Stream<Result<TodoStats>> _mapToGetTodoListState() => _$fetchTodosEvent
      .startWith(null)
      .switchMap((value) {
        return todoService.getTodos(FilterEnum.showAll).map(
              (event) => TodoStats(
                completedTodos:
                    event.where((element) => element.complete == true).length,
                activeTodos:
                    event.where((element) => element.complete == false).length,
              ),
            );
      })
      .shareReplay()
      .asResultStream();
}
