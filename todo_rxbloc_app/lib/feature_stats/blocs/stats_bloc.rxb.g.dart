// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'stats_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class StatsBlocType extends RxBlocTypeBase {
  StatsBlocEvents get events;
  StatsBlocStates get states;
}

/// [$StatsBloc] extended by the [StatsBloc]
/// {@nodoc}
abstract class $StatsBloc extends RxBlocBase
    implements StatsBlocEvents, StatsBlocStates, StatsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchTodos]
  final _$fetchTodosEvent = PublishSubject<void>();

  /// The state of [getTodoList] implemented in [_mapToGetTodoListState]
  late final Stream<Result<List<TodoEntity>>> _getTodoListState =
      _mapToGetTodoListState();

  @override
  void fetchTodos() => _$fetchTodosEvent.add(null);

  @override
  Stream<Result<List<TodoEntity>>> get getTodoList => _getTodoListState;

  Stream<Result<List<TodoEntity>>> _mapToGetTodoListState();

  @override
  StatsBlocEvents get events => this;

  @override
  StatsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchTodosEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
