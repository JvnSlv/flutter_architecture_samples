import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:uuid/uuid.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
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
    required this.uuid,
    required this.todoService,
    required this.coordinatorBloc,
    TodoEntity? todo,
  }) : _todo = todo {
    if (todo != null) {
      _$setTitleEvent.add(todo.task);
      _$setDescriptionEvent.add(todo.note);
    }
  }
  final TodoService todoService;
  final Uuid uuid;
  final NavigationBlocType navigationBloc;
  final CoordinatorBlocType coordinatorBloc;
  final TodoEntity? _todo;

  @override
  Stream<String> _mapToValidateTitleState() => _$setTitleEvent;

  @override
  Stream<NewTodoEnum> _mapToNewTodoState() => _$saveTodoEvent
      .createTodo(
        todoService,
        _$setTitleEvent.startWith(''),
        _$setDescriptionEvent,
        uuid,
        navigationBloc,
        this,
        _todo,
        coordinatorBloc,
      )
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
