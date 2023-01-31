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

  /// The state of [deletedTodo] implemented in [_mapToDeletedTodoState]
  late final Stream<TodoEntity> _deletedTodoState = _mapToDeletedTodoState();

  @override
  void deleteTodo(TodoEntity todo) => _$deleteTodoEvent.add(todo);

  @override
  Stream<TodoEntity> get deletedTodo => _deletedTodoState;

  Stream<TodoEntity> _mapToDeletedTodoState();

  @override
  CoordinatorEvents get events => this;

  @override
  CoordinatorStates get states => this;

  @override
  void dispose() {
    _$deleteTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
