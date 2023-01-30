// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'coordinator_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class CoordinatorBlocType extends RxBlocTypeBase {
  CoordinatorEvents get events;
  CoordinatorStates get states;
}

/// [$CoordinatorBloc] extended by the [CoordinatorBloc]
/// {@nodoc}
abstract class $CoordinatorBloc extends RxBlocBase
    implements CoordinatorEvents, CoordinatorStates, CoordinatorBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [deleteTodo]
  final _$deleteTodoEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [updateTodo]
  final _$updateTodoEvent = PublishSubject<TodoEntity>();

  /// The state of [todoDeleted] implemented in [_mapToTodoDeletedState]
  late final Stream<TodoEntity> _todoDeletedState = _mapToTodoDeletedState();

  /// The state of [todoUpdated] implemented in [_mapToTodoUpdatedState]
  late final Stream<TodoEntity> _todoUpdatedState = _mapToTodoUpdatedState();

  @override
  void deleteTodo(TodoEntity todo) => _$deleteTodoEvent.add(todo);

  @override
  void updateTodo(TodoEntity todo) => _$updateTodoEvent.add(todo);

  @override
  Stream<TodoEntity> get todoDeleted => _todoDeletedState;

  @override
  Stream<TodoEntity> get todoUpdated => _todoUpdatedState;

  Stream<TodoEntity> _mapToTodoDeletedState();

  Stream<TodoEntity> _mapToTodoUpdatedState();

  @override
  CoordinatorEvents get events => this;

  @override
  CoordinatorStates get states => this;

  @override
  void dispose() {
    _$deleteTodoEvent.close();
    _$updateTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
