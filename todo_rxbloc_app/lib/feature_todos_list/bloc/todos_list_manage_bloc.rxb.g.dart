// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todos_list_manage_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodosListManageBlocType extends RxBlocTypeBase {
  TodosListManageBlocEvents get events;
  TodosListManageBlocStates get states;
}

/// [$TodosListManageBloc] extended by the [TodosListManageBloc]
/// {@nodoc}
abstract class $TodosListManageBloc extends RxBlocBase
    implements
        TodosListManageBlocEvents,
        TodosListManageBlocStates,
        TodosListManageBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [addTodo]
  final _$addTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [updateTodo]
  final _$updateTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [deleteTodo]
  final _$deleteTodoEvent = PublishSubject<TodoEntity>();

  /// The state of [todoDeleted] implemented in [_mapToTodoDeletedState]
  late final Stream<TodoEntity> _todoDeletedState = _mapToTodoDeletedState();

  /// The state of [todoUpdated] implemented in [_mapToTodoUpdatedState]
  late final ConnectableStream<void> _todoUpdatedState =
      _mapToTodoUpdatedState();

  /// The state of [todoAdded] implemented in [_mapToTodoAddedState]
  late final ConnectableStream<void> _todoAddedState = _mapToTodoAddedState();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  @override
  void addTodo(TodoEntity todo) => _$addTodoEvent.add(todo);

  @override
  void updateTodo(TodoEntity todo) => _$updateTodoEvent.add(todo);

  @override
  void deleteTodo(TodoEntity todo) => _$deleteTodoEvent.add(todo);

  @override
  Stream<TodoEntity> get todoDeleted => _todoDeletedState;

  @override
  ConnectableStream<void> get todoUpdated => _todoUpdatedState;

  @override
  ConnectableStream<void> get todoAdded => _todoAddedState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  Stream<TodoEntity> _mapToTodoDeletedState();

  ConnectableStream<void> _mapToTodoUpdatedState();

  ConnectableStream<void> _mapToTodoAddedState();

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  @override
  TodosListManageBlocEvents get events => this;

  @override
  TodosListManageBlocStates get states => this;

  @override
  void dispose() {
    _$addTodoEvent.close();
    _$updateTodoEvent.close();
    _$deleteTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
