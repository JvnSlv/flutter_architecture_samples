import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/manage_todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'manage_todo_bloc.rxb.g.dart';
part 'manage_todo_bloc_extensions.dart';
part 'manage_todo_bloc_models.dart';

/// A contract class containing all events of the ManageTodoBloC.
abstract class ManageTodoBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour)
  void setTitle(String title);
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setDescription(String description);
  void saveTodo();
  void updateTodo();
}

/// A contract class containing all states of the ManageTodoBloC.
abstract class ManageTodoBlocStates {
  Stream<String> get validateTitle;
  Stream<NewTodoEnum> get newTodo;
  Stream<String> get getDescription;
  Stream<String> get errors;
  Stream<bool> get isLoading;
}

@RxBloc()
class ManageTodoBloc extends $ManageTodoBloc {
  ManageTodoBloc({
    required this.navigationBloc,
    required this.coordinatorBloc,
    required this.manageTodoService,
    TodoEntity? todo,
  }) : _todo = todo {
    if (todo != null) {
      _$setTitleEvent.add(todo.task);
      _$setDescriptionEvent.add(todo.note);
    }
  }

  final NavigationBlocType navigationBloc;
  final CoordinatorBlocType coordinatorBloc;
  final TodoEntity? _todo;
  final ManageTodoService manageTodoService;

  @override
  Stream<String> _mapToValidateTitleState() => _$setTitleEvent;

  @override
  Stream<NewTodoEnum> _mapToNewTodoState() => Rx.merge([
        _$saveTodoEvent.createTodo(
          _$setTitleEvent.startWith(''),
          _$setDescriptionEvent,
          navigationBloc,
          manageTodoService,
        ),
        _$updateTodoEvent.updateTodo(
          _$setTitleEvent.startWith(''),
          _$setDescriptionEvent,
          navigationBloc,
          _todo,
          coordinatorBloc,
          manageTodoService,
        )
      ])
          .asResultStream()
          .setResultStateHandler(this)
          .whereSuccess()
          .shareReplay()
          .asBroadcastStream();

  @override
  Stream<String> _mapToGetDescriptionState() =>
      _$setDescriptionEvent.startWith(_todo?.note ?? '');

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((Exception error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
