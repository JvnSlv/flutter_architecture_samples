// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'add_todo_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class AddTodoBlocType extends RxBlocTypeBase {
  AddTodoBlocEvents get events;
  AddTodoBlocStates get states;
}

/// [$AddTodoBloc] extended by the [AddTodoBloc]
/// {@nodoc}
abstract class $AddTodoBloc extends RxBlocBase
    implements AddTodoBlocEvents, AddTodoBlocStates, AddTodoBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [setTitle]
  final _$setTitleEvent = BehaviorSubject<String>();

  /// Тhe [Subject] where events sink to by calling [setDescription]
  final _$setDescriptionEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [saveTodo]
  final _$saveTodoEvent = PublishSubject<void>();

  /// The state of [validateTitle] implemented in [_mapToValidateTitleState]
  late final Stream<String> _validateTitleState = _mapToValidateTitleState();

  /// The state of [newTodo] implemented in [_mapToNewTodoState]
  late final Stream<NewTodoEnum> _newTodoState = _mapToNewTodoState();

  @override
  void setTitle(String title) => _$setTitleEvent.add(title);

  @override
  void setDescription(String description) =>
      _$setDescriptionEvent.add(description);

  @override
  void saveTodo() => _$saveTodoEvent.add(null);

  @override
  Stream<String> get validateTitle => _validateTitleState;

  @override
  Stream<NewTodoEnum> get newTodo => _newTodoState;

  Stream<String> _mapToValidateTitleState();

  Stream<NewTodoEnum> _mapToNewTodoState();

  @override
  AddTodoBlocEvents get events => this;

  @override
  AddTodoBlocStates get states => this;

  @override
  void dispose() {
    _$setTitleEvent.close();
    _$setDescriptionEvent.close();
    _$saveTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
