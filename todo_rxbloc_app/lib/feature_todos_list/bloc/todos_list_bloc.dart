import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../../base/services/todo_service.dart';
import '../../base/utils/constants.dart';

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
  Stream<TodoEntity> get isTodoDeleted;
  Stream<TodoEntity?> get navigate;
}

@RxBloc()
class TodosListBloc extends $TodosListBloc {
  TodosListBloc({
    required this.router,
    required this.todoService,
  });
  final TodoService todoService;
  final GoRouter router;
  List<TodoEntity> _todosList = [];

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodosListState() {
    return Rx.merge([
      _$addTodoEvent.switchMap((value) async* {
        if (!_todosList.contains(value)) {
          await todoService.addTodo(value);
        }
        yield _todosList;
      }),
      _$fetchTodosListEvent.startWith(null).switchMap(
            (value) => todoService.getTodos().doOnData((event) {
              _todosList = event;
            }),
          ),
      _$updateTodoEvent.switchMap((value) async* {
        await todoService.updateTodo(value.copyWith(complete: !value.complete));
        yield _todosList;
      }),
    ]).distinct().shareReplay(maxSize: 1).asResultStream();
  }

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
          router.push(TodoConstants.addTodoRoute);
        } else {
          router.push(TodoConstants.todoDetails, extra: event);
        }
      });
}
