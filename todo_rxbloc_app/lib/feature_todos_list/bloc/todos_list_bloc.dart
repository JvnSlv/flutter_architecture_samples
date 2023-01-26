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
  void navigateToPage(NavigationParametars navigationParametars);
}

abstract class TodosListBlocStates {
  Stream<Result<List<TodoEntity>>> get todosList;
  Stream<NavigationParametars> get navigate;
}

@RxBloc()
class TodosListBloc extends $TodosListBloc {
  TodosListBloc({
    required this.navigationBloc,
    required this.todoService,
  });
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
  Stream<NavigationParametars> _mapToNavigateState() =>
      _$navigateToPageEvent.doOnData((event) {
        navigationBloc.events.navigate(event);
      });
}
