import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  void toggleTodo(TodoEntity todoEntity, bool isComplete);
  void navigate(NavigationParametars navigationParametars);
  void deleteTodo(TodoEntity todoEntity);
}

/// A contract class containing all states of the TodoDetailsBloC.
abstract class TodoDetailsBlocStates {
  Stream<TodoEntity> get todoEntity;
  ConnectableStream<void> get setNavigation;
  ConnectableStream<void> get todoDeleted;
}

@RxBloc()
class TodoDetailsBloc extends $TodoDetailsBloc {
  final TodoService service;
  final NavigationBlocType navigationBloc;

  TodoDetailsBloc({required this.navigationBloc, required this.service}) {
    setNavigation.connect().addTo(_compositeSubscription);
    todoDeleted.connect().addTo(_compositeSubscription);
  }
  @override
  Stream<TodoEntity> _mapToTodoEntityState() => _$toggleTodoEvent
      .switchMap((value) async* {
        final TodoEntity todo =
            value.todoEntity.copyWith(complete: value.isComplete);
        await service.updateTodo(todo);
        yield todo;
      })
      .shareReplay()
      .asBroadcastStream();

  @override
  ConnectableStream<void> _mapToSetNavigationState() =>
      _$navigateEvent.doOnData((event) {
        navigationBloc.events.navigate(event);
      }).publish();

  @override
  ConnectableStream<void> _mapToTodoDeletedState() =>
      _$deleteTodoEvent.doOnData((todoEntity) {
        service.delteTodo(todoEntity);
        navigationBloc.events.navigate(
          const NavigationParametars(navigationEnum: NavigationEnum.todosList),
        );
      }).publish();
}
