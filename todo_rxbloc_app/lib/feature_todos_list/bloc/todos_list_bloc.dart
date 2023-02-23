import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/enums/filter_enum.dart';
import '../../base/models/navigation_parameters.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todos_list_bloc.rxb.g.dart';
part 'todos_list_bloc_extensions.dart';

abstract class TodosListBlocEvents {
  void fetchTodosList();
  void filterMenuAction(FilterEnum filterEnum);
  void navigateToPage(NavigationParams navigationParams);
}

abstract class TodosListBlocStates {
  Stream<Result<List<TodoEntity>>> get todosList;
  Stream<NavigationParams> get navigate;

  Stream<FilterEnum> get filterValue;
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
  Stream<FilterEnum> _mapToFilterValueState() =>
      _$filterMenuActionEvent.startWith(FilterEnum.showAll);

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodosListState() => Rx.merge([
        _$filterMenuActionEvent
            .switchMap((value) => todoService.getTodos(value)),
        _$fetchTodosListEvent
            .startWith(null)
            .switchMap((value) => todoService.getTodos(FilterEnum.showAll))
      ]).distinct().shareReplay(maxSize: 1).asResultStream();

  @override
  Stream<NavigationParams> _mapToNavigateState() =>
      _$navigateToPageEvent.doOnData((event) {
        navigationBloc.events.navigate(event);
      });
}
