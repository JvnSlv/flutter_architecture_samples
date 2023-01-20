// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todos_list_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodosListBlocType extends RxBlocTypeBase {
  TodosListBlocEvents get events;
  TodosListBlocStates get states;
}

/// [$TodosListBloc] extended by the [TodosListBloc]
/// {@nodoc}
abstract class $TodosListBloc extends RxBlocBase
    implements TodosListBlocEvents, TodosListBlocStates, TodosListBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchTodosList]
  final _$fetchTodosListEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [updateTodo]
  final _$updateTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [deleteTodo]
  final _$deleteTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [addTodo]
  final _$addTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [navigateToPage]
  final _$navigateToPageEvent = PublishSubject<NavigationParametars>();

  /// The state of [todosList] implemented in [_mapToTodosListState]
  late final Stream<Result<List<TodoEntity>>> _todosListState =
      _mapToTodosListState();

  /// The state of [updatedTodo] implemented in [_mapToUpdatedTodoState]
  late final ConnectableStream<void> _updatedTodoState =
      _mapToUpdatedTodoState();

  /// The state of [addedTodo] implemented in [_mapToAddedTodoState]
  late final ConnectableStream<void> _addedTodoState = _mapToAddedTodoState();

  /// The state of [isTodoDeleted] implemented in [_mapToIsTodoDeletedState]
  late final Stream<TodoEntity> _isTodoDeletedState =
      _mapToIsTodoDeletedState();

  /// The state of [navigate] implemented in [_mapToNavigateState]
  late final Stream<NavigationParametars> _navigateState =
      _mapToNavigateState();

  @override
  void fetchTodosList() => _$fetchTodosListEvent.add(null);

  @override
  void updateTodo(TodoEntity todo) => _$updateTodoEvent.add(todo);

  @override
  void deleteTodo(TodoEntity todo) => _$deleteTodoEvent.add(todo);

  @override
  void addTodo(TodoEntity todo) => _$addTodoEvent.add(todo);

  @override
  void navigateToPage(NavigationParametars navigationParametars) =>
      _$navigateToPageEvent.add(navigationParametars);

  @override
  Stream<Result<List<TodoEntity>>> get todosList => _todosListState;

  @override
  ConnectableStream<void> get updatedTodo => _updatedTodoState;

  @override
  ConnectableStream<void> get addedTodo => _addedTodoState;

  @override
  Stream<TodoEntity> get isTodoDeleted => _isTodoDeletedState;

  @override
  Stream<NavigationParametars> get navigate => _navigateState;

  Stream<Result<List<TodoEntity>>> _mapToTodosListState();

  ConnectableStream<void> _mapToUpdatedTodoState();

  ConnectableStream<void> _mapToAddedTodoState();

  Stream<TodoEntity> _mapToIsTodoDeletedState();

  Stream<NavigationParametars> _mapToNavigateState();

  @override
  TodosListBlocEvents get events => this;

  @override
  TodosListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchTodosListEvent.close();
    _$updateTodoEvent.close();
    _$deleteTodoEvent.close();
    _$addTodoEvent.close();
    _$navigateToPageEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
