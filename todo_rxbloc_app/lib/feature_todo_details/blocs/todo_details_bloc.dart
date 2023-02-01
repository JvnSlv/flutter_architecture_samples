import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/models/navigation_parametars.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  void toggleTodo(TodoEntity todoEntity, bool isComplete);
  void navigate(NavigationParams navigationParametars);
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
  final NavigationBlocType navigationBloc;
  final CoordinatorBlocType coordinatorBloc;

  TodoDetailsBloc({
    required this.coordinatorBloc,
    required this.navigationBloc,
  }) {
    setNavigation.connect().addTo(_compositeSubscription);
    todoDeleted.connect().addTo(_compositeSubscription);
    coordinatorBloc.states.sendUpdatedTodo
        .bind(_updatedSubject)
        .addTo(_compositeSubscription);
  }

  final _updatedSubject = BehaviorSubject<TodoEntity>();

  @override
  Stream<TodoEntity> _mapToTodoEntityState() => Rx.merge([
        _$toggleTodoEvent.doOnData((event) {
          coordinatorBloc.events.updateTodo(
            event.todoEntity.copyWith(complete: event.isComplete),
          );
        }).switchMap((value) async* {
          yield Result.success(
              value.todoEntity.copyWith(complete: value.isComplete));
        }),
        _updatedSubject.doOnData((event) {
          print(event);
        }).asResultStream(),
      ])
          .setResultStateHandler(this)
          .whereSuccess()
          .shareReplay(maxSize: 1)
          .asBroadcastStream();

  @override
  ConnectableStream<void> _mapToSetNavigationState() =>
      _$navigateEvent.doOnData((event) {
        navigationBloc.events.navigate(event);
      }).publish();

  @override
  ConnectableStream<void> _mapToTodoDeletedState() =>
      _$deleteTodoEvent.doOnData((todoEntity) {
        coordinatorBloc.events.deleteTodo(todoEntity);
      }).publish();
}
