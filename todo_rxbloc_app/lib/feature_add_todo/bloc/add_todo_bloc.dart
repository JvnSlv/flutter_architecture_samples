import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:uuid/uuid.dart' as id;
import 'package:uuid/uuid.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/model/navigation_parametars.dart';
import '../../base/services/todo_service.dart';

part 'add_todo_bloc.rxb.g.dart';
part 'add_todo_bloc_extensions.dart';

/// A contract class containing all events of the AddTodoBloC.
abstract class AddTodoBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
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
    required this.coordinatorBloc,
    required this.uuid,
    required this.todoService,
  });
  final TodoService todoService;
  final id.Uuid uuid;
  final CoordinatorBlocType coordinatorBloc;

  @override
  Stream<String> _mapToValidateTitleState() => _$setTitleEvent.debounceTime(
        const Duration(milliseconds: 500),
      );

  @override
  Stream<NewTodoEnum> _mapToNewTodoState() => _$saveTodoEvent
      .createTodo(todoService, _$setTitleEvent, _$setDescriptionEvent, uuid,
          coordinatorBloc)
      .shareReplay(maxSize: 1)
      .asBroadcastStream();
}
