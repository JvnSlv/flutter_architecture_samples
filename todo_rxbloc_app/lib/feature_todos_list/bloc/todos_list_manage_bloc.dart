import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todos_list_manage_bloc.rxb.g.dart';
part 'todos_list_manage_bloc_extensions.dart';

/// A contract class containing all events of the TodosListManageBloC.
abstract class TodosListManageBlocEvents {
  void addTodo(TodoEntity todo);
  void updateTodo(TodoEntity todo);
  void deleteTodo(TodoEntity todo);
}

/// A contract class containing all states of the TodosListManageBloC.
abstract class TodosListManageBlocStates {
  Stream<TodoEntity> get todoDeleted;
  ConnectableStream<void> get todoUpdated;
  ConnectableStream<void> get todoAdded;
}

@RxBloc()
class TodosListManageBloc extends $TodosListManageBloc {
  final TodoService todoService;
  final CoordinatorBlocType coordinatorBloc;
  final NavigationBlocType navigationBloc;
  TodosListManageBloc(
      {required this.navigationBloc,
      required this.coordinatorBloc,
      required this.todoService}) {
    todoUpdated.connect().addTo(_compositeSubscription);
    todoAdded.connect().addTo(_compositeSubscription);
    coordinatorBloc.states.todoDeleted
        .bind(_deleteSubject)
        .addTo(_compositeSubscription);
    coordinatorBloc.states.todoUpdated
        .bind(_updateSubject)
        .addTo(_compositeSubscription);
  }

  final _deleteSubject = BehaviorSubject<TodoEntity>();
  final _updateSubject = BehaviorSubject<TodoEntity>();

  @override
  ConnectableStream<void> _mapToTodoAddedState() =>
      _$addTodoEvent.doOnData((todo) {
        todoService.addTodo(todo);
      }).publish();

  @override
  Stream<TodoEntity> _mapToTodoDeletedState() => Rx.merge([
        _$deleteTodoEvent.doOnData((todo) {
          todoService.delteTodo(todo);
        }),
        _deleteSubject.doOnData((todo) {
          todoService.delteTodo(todo);
          navigationBloc.events.navigate(
            const NavigationParams(navigationEnum: NavigationEnum.todosList),
          );
        })
      ]);

  @override
  ConnectableStream<void> _mapToTodoUpdatedState() => Rx.merge([
        _$updateTodoEvent.doOnData((todo) {
          todoService.updateTodo(todo.copyWith(complete: !todo.complete));
        }),
        _updateSubject.doOnData(
          (todo) => todoService.updateTodo(todo),
        )
      ]).publish();
}
