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

  /// Тhe [Subject] where events sink to by calling [navigateToPage]
  final _$navigateToPageEvent = PublishSubject<NavigationParams>();

  /// The state of [todosList] implemented in [_mapToTodosListState]
  late final Stream<Result<List<TodoEntity>>> _todosListState =
      _mapToTodosListState();

  /// The state of [navigate] implemented in [_mapToNavigateState]
  late final Stream<NavigationParams> _navigateState = _mapToNavigateState();

  @override
  void fetchTodosList() => _$fetchTodosListEvent.add(null);

  @override
  void navigateToPage(NavigationParams navigationParametars) =>
      _$navigateToPageEvent.add(navigationParametars);

  @override
  Stream<Result<List<TodoEntity>>> get todosList => _todosListState;

  @override
  Stream<NavigationParams> get navigate => _navigateState;

  Stream<Result<List<TodoEntity>>> _mapToTodosListState();

  Stream<NavigationParams> _mapToNavigateState();

  @override
  TodosListBlocEvents get events => this;

  @override
  TodosListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchTodosListEvent.close();
    _$navigateToPageEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
