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

  /// Тhe [Subject] where events sink to by calling [deleteTodo]
  final _$deleteTodoEvent = PublishSubject<TodoEntity>();

  /// The state of [updatedTodo] implemented in [_mapToUpdatedTodoState]
  late final Stream<TodoEntity> _updatedTodoState = _mapToUpdatedTodoState();

  /// The state of [deletedTodo] implemented in [_mapToDeletedTodoState]
  late final ConnectableStream<void> _deletedTodoState =
      _mapToDeletedTodoState();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

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
  void deleteTodo(TodoEntity todoEntity) => _$deleteTodoEvent.add(todoEntity);

  @override
  Stream<TodoEntity> get updatedTodo => _updatedTodoState;

  @override
  ConnectableStream<void> get deletedTodo => _deletedTodoState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  Stream<TodoEntity> _mapToUpdatedTodoState();

  ConnectableStream<void> _mapToDeletedTodoState();

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  @override
  TodoDetailsBlocEvents get events => this;

  @override
  TodoDetailsBlocStates get states => this;

  @override
  void dispose() {
    _$toggleTodoEvent.close();
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
