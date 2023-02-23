// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todos_manage_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodosManageBlocType extends RxBlocTypeBase {
  TodosManageBlocEvents get events;
  TodosManageBlocStates get states;
}

/// [$TodosManageBloc] extended by the [TodosManageBloc]
/// {@nodoc}
abstract class $TodosManageBloc extends RxBlocBase
    implements
        TodosManageBlocEvents,
        TodosManageBlocStates,
        TodosManageBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [getTodosList]
  final _$getTodosListEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [markAll]
  final _$markAllEvent =
      BehaviorSubject<OptionsMenuEnum>.seeded(OptionsMenuEnum.markAllComplete);

  /// Тhe [Subject] where events sink to by calling [deleteMarked]
  final _$deleteMarkedEvent = PublishSubject<void>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [markTodosComplete] implemented in
  /// [_mapToMarkTodosCompleteState]
  late final Stream<ReturnValues> _markTodosCompleteState =
      _mapToMarkTodosCompleteState();

  /// The state of [deleteMarkedTodos] implemented in
  /// [_mapToDeleteMarkedTodosState]
  late final ConnectableStream<void> _deleteMarkedTodosState =
      _mapToDeleteMarkedTodosState();

  /// The state of [todosList] implemented in [_mapToTodosListState]
  late final ConnectableStream<List<TodoEntity>> _todosListState =
      _mapToTodosListState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  void getTodosList() => _$getTodosListEvent.add(null);

  @override
  void markAll(OptionsMenuEnum option) => _$markAllEvent.add(option);

  @override
  void deleteMarked() => _$deleteMarkedEvent.add(null);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<ReturnValues> get markTodosComplete => _markTodosCompleteState;

  @override
  ConnectableStream<void> get deleteMarkedTodos => _deleteMarkedTodosState;

  @override
  ConnectableStream<List<TodoEntity>> get todosList => _todosListState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<ReturnValues> _mapToMarkTodosCompleteState();

  ConnectableStream<void> _mapToDeleteMarkedTodosState();

  ConnectableStream<List<TodoEntity>> _mapToTodosListState();

  @override
  TodosManageBlocEvents get events => this;

  @override
  TodosManageBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _$getTodosListEvent.close();
    _$markAllEvent.close();
    _$deleteMarkedEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
