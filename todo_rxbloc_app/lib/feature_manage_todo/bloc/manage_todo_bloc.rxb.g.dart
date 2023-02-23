// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'manage_todo_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class ManageTodoBlocType extends RxBlocTypeBase {
  ManageTodoBlocEvents get events;
  ManageTodoBlocStates get states;
}

/// [$ManageTodoBloc] extended by the [ManageTodoBloc]
/// {@nodoc}
abstract class $ManageTodoBloc extends RxBlocBase
    implements ManageTodoBlocEvents, ManageTodoBlocStates, ManageTodoBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [setTitle]
  final _$setTitleEvent = BehaviorSubject<String>();

  /// Тhe [Subject] where events sink to by calling [setDescription]
  final _$setDescriptionEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [saveTodo]
  final _$saveTodoEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [updateTodo]
  final _$updateTodoEvent = PublishSubject<void>();

  /// The state of [title] implemented in [_mapToTitleState]
  late final Stream<String> _titleState = _mapToTitleState();

  /// The state of [newTodo] implemented in [_mapToNewTodoState]
  late final Stream<NewTodoEnum> _newTodoState = _mapToNewTodoState();

  /// The state of [description] implemented in [_mapToDescriptionState]
  late final Stream<String> _descriptionState = _mapToDescriptionState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errorVisible] implemented in [_mapToErrorVisibleState]
  late final Stream<bool> _errorVisibleState = _mapToErrorVisibleState();

  @override
  void setTitle(String title) => _$setTitleEvent.add(title);

  @override
  void setDescription(String description) =>
      _$setDescriptionEvent.add(description);

  @override
  void saveTodo() => _$saveTodoEvent.add(null);

  @override
  void updateTodo() => _$updateTodoEvent.add(null);

  @override
  Stream<String> get title => _titleState;

  @override
  Stream<NewTodoEnum> get newTodo => _newTodoState;

  @override
  Stream<String> get description => _descriptionState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<bool> get errorVisible => _errorVisibleState;

  Stream<String> _mapToTitleState();

  Stream<NewTodoEnum> _mapToNewTodoState();

  Stream<String> _mapToDescriptionState();

  Stream<String> _mapToErrorsState();

  Stream<bool> _mapToIsLoadingState();

  Stream<bool> _mapToErrorVisibleState();

  @override
  ManageTodoBlocEvents get events => this;

  @override
  ManageTodoBlocStates get states => this;

  @override
  void dispose() {
    _$setTitleEvent.close();
    _$setDescriptionEvent.close();
    _$saveTodoEvent.close();
    _$updateTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
