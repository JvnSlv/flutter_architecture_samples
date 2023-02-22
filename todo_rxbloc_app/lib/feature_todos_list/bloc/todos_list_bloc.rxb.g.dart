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

  /// Тhe [Subject] where events sink to by calling [filterMenuAction]
  final _$filterMenuActionEvent = PublishSubject<FilterEnum>();

  /// Тhe [Subject] where events sink to by calling [navigateToPage]
  final _$navigateToPageEvent = PublishSubject<NavigationParams>();

  /// The state of [todosList] implemented in [_mapToTodosListState]
  late final Stream<Result<List<TodoEntity>>> _todosListState =
      _mapToTodosListState();

  /// The state of [navigate] implemented in [_mapToNavigateState]
  late final Stream<NavigationParams> _navigateState = _mapToNavigateState();

  /// The state of [filterValue] implemented in [_mapToFilterValueState]
  late final Stream<FilterEnum> _filterValueState = _mapToFilterValueState();

  @override
  void fetchTodosList() => _$fetchTodosListEvent.add(null);

  @override
  void filterMenuAction(FilterEnum filterEnum) =>
      _$filterMenuActionEvent.add(filterEnum);

  @override
  void navigateToPage(NavigationParams navigationParams) =>
      _$navigateToPageEvent.add(navigationParams);

  @override
  Stream<Result<List<TodoEntity>>> get todosList => _todosListState;

  @override
  Stream<NavigationParams> get navigate => _navigateState;

  @override
  Stream<FilterEnum> get filterValue => _filterValueState;

  Stream<Result<List<TodoEntity>>> _mapToTodosListState();

  Stream<NavigationParams> _mapToNavigateState();

  Stream<FilterEnum> _mapToFilterValueState();

  @override
  TodosListBlocEvents get events => this;

  @override
  TodosListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchTodosListEvent.close();
    _$filterMenuActionEvent.close();
    _$navigateToPageEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
