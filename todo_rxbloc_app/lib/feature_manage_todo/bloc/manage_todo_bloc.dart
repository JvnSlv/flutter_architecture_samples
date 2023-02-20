import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/enums/new_todo_enum.dart';
import '../../base/models/navigation_parameters.dart';
import '../../base/services/manage_todo_service.dart';
import '../../base/utils/validators/title_validator.dart' as validator;
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

  Stream<bool> get showErrors;
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
  Stream<bool> _mapToShowErrorsState() => _$saveTodoEvent
      .map((event) => true)
      .startWith(false)
      .shareReplay(maxSize: 1);

  @override
  Stream<String> _mapToValidateTitleState() =>
      _$setTitleEvent.startWith(_todo?.task ?? '').map((event) {
        return validator.validateTitle(event);
      }).shareReplay(maxSize: 1);

  @override
  Stream<NewTodoEnum> _mapToNewTodoState() => Rx.merge([
        _$saveTodoEvent
            .createTodo(
          _$setTitleEvent.startWith(''),
          _$setDescriptionEvent,
          manageTodoService,
        )
            .doOnData((event) {
          popNavigator(event, NewTodoEnum.newTodoSuccess);
        }),
        _$updateTodoEvent
            .updateTodo(
          _$setTitleEvent.startWith(''),
          _$setDescriptionEvent,
          _todo,
          manageTodoService,
          coordinatorBloc,
        )
            .doOnData((event) {
          popNavigator(event, NewTodoEnum.editTodoSuccess);
        })
      ]).setResultStateHandler(this).whereSuccess().shareReplay(maxSize: 1);

  void popNavigator(Result<NewTodoEnum> event, NewTodoEnum enumValue) {
    event.mapResult((enumResult) {
      if (enumResult == enumValue) {
        navigationBloc.events.navigate(
          const NavigationParams(navigationEnum: NavigationEnum.pop),
        );
      }
    });
  }

  @override
  Stream<String> _mapToGetDescriptionState() =>
      _$setDescriptionEvent.startWith(_todo?.note ?? '');

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((Exception error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
