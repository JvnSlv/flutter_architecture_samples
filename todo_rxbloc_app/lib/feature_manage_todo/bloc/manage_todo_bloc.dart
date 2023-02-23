import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/services/manage_todo_service.dart';
import '../../base/utils/validators/title_validator.dart' as validator;
import '../../feature_homepage/bloc/navigation_bloc.dart';

part 'manage_todo_bloc.rxb.g.dart';
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
  Stream<String> get title;
  Stream<NewTodoEnum> get newTodo;
  Stream<String> get description;
  Stream<String> get errors;
  Stream<bool> get isLoading;

  Stream<bool> get errorVisible;
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
      setTitle(todo.task);
      setDescription(todo.note);
    }
  }

  final NavigationBlocType navigationBloc;
  final CoordinatorBlocType coordinatorBloc;
  final TodoEntity? _todo;
  final ManageTodoService manageTodoService;

  @override
  Stream<bool> _mapToErrorVisibleState() =>
      _$saveTodoEvent.mapTo(true).startWith(false).shareReplay(maxSize: 1);

  @override
  Stream<String> _mapToTitleState() => _$setTitleEvent
      .startWith(_todo?.task ?? '')
      .map((event) => validator.validateTitle(event))
      .shareReplay(maxSize: 1);

  @override
  Stream<NewTodoEnum> _mapToNewTodoState() => Rx.merge([
        _$saveTodoEvent
            .withLatestFrom2<String, String, TextFieldsData>(
              title,
              description,
              (_, String title, String desc) =>
                  TextFieldsData(title: title, description: desc),
            )
            .switchMap(
              (value) => manageTodoService
                  .createTodo(value.title, value.description)
                  .asResultStream(),
            ),
        _$updateTodoEvent
            .withLatestFrom2<String, String, TextFieldsData>(
              title,
              description,
              (_, String title, String desc) =>
                  TextFieldsData(title: title, description: desc),
            )
            .switchMap(
              (value) => manageTodoService
                  .updateTodo(
                    _todo!.copyWith(
                      note: value.description,
                      task: value.title,
                    ),
                  )
                  .asResultStream(),
            )
            .doOnData((event) => event.mapResult(
                (todo) => coordinatorBloc.events.receiveUpdatedTodo(todo)))
      ])
          .setResultStateHandler(this)
          .whereSuccess()
          .doOnData((event) {
            navigationBloc.events.navigate(
              const NavigationParams(navigationEnum: NavigationEnum.pop),
            );
          })
          .map((event) => _returnEnum(event))
          .shareReplay(maxSize: 1);

  NewTodoEnum _returnEnum(TodoEntity todo) {
    if (todo.id == _todo?.id) {
      return NewTodoEnum.editTodoSuccess;
    } else {
      return NewTodoEnum.newTodoSuccess;
    }
  }

  @override
  Stream<String> _mapToDescriptionState() =>
      _$setDescriptionEvent.startWith(_todo?.note ?? '');

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((Exception error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
