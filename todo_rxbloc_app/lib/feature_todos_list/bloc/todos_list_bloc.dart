import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/model/navigation_parametars.dart';
import '../../base/services/todo_service.dart';

part 'todos_list_bloc.rxb.g.dart';
part 'todos_list_bloc_extensions.dart';

abstract class TodosListBlocEvents {
  void fetchTodosList();
  void updateTodo(TodoEntity todo);
  void deleteTodo(TodoEntity todo);
  void addTodo(TodoEntity todo);
  void navigateToPage(TodoEntity? todo);
}

abstract class TodosListBlocStates {
  Stream<Result<List<TodoEntity>>> get todosList;
  ConnectableStream<void> get isTodoAdded;
  ConnectableStream<void> get updatedTodo;
  Stream<TodoEntity> get isTodoDeleted;
  Stream<TodoEntity?> get navigate;
}

@RxBloc()
class TodosListBloc extends $TodosListBloc {
  TodosListBloc({
    required this.coordinatorBloc,
    required this.todoService,
  }) {
    isTodoAdded.connect().addTo(_compositeSubscription);
    updatedTodo.connect().addTo(_compositeSubscription);
  }

  final TodoService todoService;
  final CoordinatorBlocType coordinatorBloc;

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodosListState() =>
      _$fetchTodosListEvent
          .startWith(null)
          .switchMap((value) => todoService.getTodos())
          .distinct()
          .asResultStream()
          .setResultStateHandler(this);

  @override
  Stream<TodoEntity> _mapToIsTodoDeletedState() =>
      _$deleteTodoEvent.switchMap((value) async* {
        await todoService.delteTodo(value);
        yield value;
      });

  @override
  Stream<TodoEntity?> _mapToNavigateState() =>
      _$navigateToPageEvent.doOnData((event) {
        if (event == null) {
          coordinatorBloc.events.navigate(const NavigationParametars(
            navigationEnum: NavigationEnum.addTodo,
          ));
        } else {
          coordinatorBloc.events.navigate(NavigationParametars(
            navigationEnum: NavigationEnum.todoDetails,
            extraParametars: event,
          ));
        }
      });

  @override
  ConnectableStream<void> _mapToIsTodoAddedState() => _$addTodoEvent
      .switchMap((value) => todoService.addTodo(value).asResultStream())
      .publish();

  @override
  ConnectableStream<void> _mapToUpdatedTodoState() => _$updateTodoEvent
      .switchMap((value) => todoService
          .updateTodo(value.copyWith(complete: !value.complete))
          .asResultStream())
      .publish();
}
