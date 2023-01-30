import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:uuid/uuid.dart';

import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/todo_service.dart';
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'add_todo_bloc.rxb.g.dart';
part 'add_todo_bloc_extensions.dart';
part 'add_todo_bloc_models.dart';

/// A contract class containing all events of the AddTodoBloC.
abstract class AddTodoBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour)
  void setTitle(String title);
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setDescription(String description);
  void saveTodo();
}

/// A contract class containing all states of the AddTodoBloC.
abstract class AddTodoBlocStates {
  Stream<String> get validateTitle;
  Stream<NewTodoEnum> get newTodo;
}

@RxBloc()
class AddTodoBloc extends $AddTodoBloc {
  AddTodoBloc({
    required this.navigationBloc,
    required this.uuid,
    required this.todoService,
  });
  final TodoService todoService;
  final Uuid uuid;
  final NavigationBlocType navigationBloc;

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
      )
      .shareReplay()
      .asBroadcastStream();
}
