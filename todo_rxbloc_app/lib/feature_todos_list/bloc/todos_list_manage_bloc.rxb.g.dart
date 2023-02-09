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

  /// Тhe [Subject] where events sink to by calling [getTodosList]
  final _$getTodosListEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [markAll]
  final _$markAllEvent =
      BehaviorSubject<OptionsMenuEnum>.seeded(OptionsMenuEnum.markAllComplete);

  /// Тhe [Subject] where events sink to by calling [deleteMarkerd]
  final _$deleteMarkerdEvent = PublishSubject<void>();

  /// The state of [todoDeleted] implemented in [_mapToTodoDeletedState]
  late final Stream<TodoEntity> _todoDeletedState = _mapToTodoDeletedState();

  /// The state of [todoUpdated] implemented in [_mapToTodoUpdatedState]
  late final ConnectableStream<void> _todoUpdatedState =
      _mapToTodoUpdatedState();

  /// The state of [todoAdded] implemented in [_mapToTodoAddedState]
  late final ConnectableStream<void> _todoAddedState = _mapToTodoAddedState();

  /// The state of [todosList] implemented in [_mapToTodosListState]
  late final ConnectableStream<List<TodoEntity>> _todosListState =
      _mapToTodosListState();

  /// The state of [markTodosComplete] implemented in
  /// [_mapToMarkTodosCompleteState]
  late final Stream<OptionsMenuEnum> _markTodosCompleteState =
      _mapToMarkTodosCompleteState();

  /// The state of [deleteMarkedTodos] implemented in
  /// [_mapToDeleteMarkedTodosState]
  late final ConnectableStream<void> _deleteMarkedTodosState =
      _mapToDeleteMarkedTodosState();

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
  void getTodosList() => _$getTodosListEvent.add(null);

  @override
  void markAll(OptionsMenuEnum option) => _$markAllEvent.add(option);

  @override
  void deleteMarkerd() => _$deleteMarkerdEvent.add(null);

  @override
  Stream<TodoEntity> get todoDeleted => _todoDeletedState;

  @override
  ConnectableStream<void> get todoUpdated => _todoUpdatedState;

  @override
  ConnectableStream<void> get todoAdded => _todoAddedState;

  @override
  ConnectableStream<List<TodoEntity>> get todosList => _todosListState;

  @override
  Stream<OptionsMenuEnum> get markTodosComplete => _markTodosCompleteState;

  @override
  ConnectableStream<void> get deleteMarkedTodos => _deleteMarkedTodosState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  Stream<TodoEntity> _mapToTodoDeletedState();

  ConnectableStream<void> _mapToTodoUpdatedState();

  ConnectableStream<void> _mapToTodoAddedState();

  ConnectableStream<List<TodoEntity>> _mapToTodosListState();

  Stream<OptionsMenuEnum> _mapToMarkTodosCompleteState();

  ConnectableStream<void> _mapToDeleteMarkedTodosState();

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
    _$getTodosListEvent.close();
    _$markAllEvent.close();
    _$deleteMarkerdEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
