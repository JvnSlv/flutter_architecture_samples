// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todo_details_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodoDetailsBlocType extends RxBlocTypeBase {
  TodoDetailsBlocEvents get events;
  TodoDetailsBlocStates get states;
}

/// [$TodoDetailsBloc] extended by the [TodoDetailsBloc]
/// {@nodoc}
abstract class $TodoDetailsBloc extends RxBlocBase
    implements
        TodoDetailsBlocEvents,
        TodoDetailsBlocStates,
        TodoDetailsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [toggleTodo]
  final _$toggleTodoEvent = PublishSubject<_ToggleTodoEventArgs>();

  /// Тhe [Subject] where events sink to by calling [navigate]
  final _$navigateEvent = PublishSubject<NavigationParams>();

  /// Тhe [Subject] where events sink to by calling [deleteTodo]
  final _$deleteTodoEvent = PublishSubject<TodoEntity>();

  /// The state of [todoEntity] implemented in [_mapToTodoEntityState]
  late final Stream<TodoEntity> _todoEntityState = _mapToTodoEntityState();

  /// The state of [setNavigation] implemented in [_mapToSetNavigationState]
  late final ConnectableStream<void> _setNavigationState =
      _mapToSetNavigationState();

  /// The state of [todoDeleted] implemented in [_mapToTodoDeletedState]
  late final ConnectableStream<void> _todoDeletedState =
      _mapToTodoDeletedState();

  @override
  void toggleTodo(
    TodoEntity todoEntity,
    bool isComplete,
  ) =>
      _$toggleTodoEvent.add(_ToggleTodoEventArgs(
        todoEntity,
        isComplete,
      ));

  @override
  void navigate(NavigationParams navigationParametars) =>
      _$navigateEvent.add(navigationParametars);

  @override
  void deleteTodo(TodoEntity todoEntity) => _$deleteTodoEvent.add(todoEntity);

  @override
  Stream<TodoEntity> get todoEntity => _todoEntityState;

  @override
  ConnectableStream<void> get setNavigation => _setNavigationState;

  @override
  ConnectableStream<void> get todoDeleted => _todoDeletedState;

  Stream<TodoEntity> _mapToTodoEntityState();

  ConnectableStream<void> _mapToSetNavigationState();

  ConnectableStream<void> _mapToTodoDeletedState();

  @override
  TodoDetailsBlocEvents get events => this;

  @override
  TodoDetailsBlocStates get states => this;

  @override
  void dispose() {
    _$toggleTodoEvent.close();
    _$navigateEvent.close();
    _$deleteTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}

/// Helps providing the arguments in the [Subject.add] for
/// [TodoDetailsBlocEvents.toggleTodo] event
class _ToggleTodoEventArgs {
  const _ToggleTodoEventArgs(
    this.todoEntity,
    this.isComplete,
  );

  final TodoEntity todoEntity;

  final bool isComplete;
}
