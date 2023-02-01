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

  /// The state of [validateTitle] implemented in [_mapToValidateTitleState]
  late final Stream<String> _validateTitleState = _mapToValidateTitleState();

  /// The state of [newTodo] implemented in [_mapToNewTodoState]
  late final Stream<NewTodoEnum> _newTodoState = _mapToNewTodoState();

  /// The state of [getDescription] implemented in [_mapToGetDescriptionState]
  late final Stream<String> _getDescriptionState = _mapToGetDescriptionState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

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

  @override
  Stream<String> get getDescription => _getDescriptionState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  Stream<String> _mapToValidateTitleState();

  Stream<NewTodoEnum> _mapToNewTodoState();

  Stream<String> _mapToGetDescriptionState();

  Stream<String> _mapToErrorsState();

  Stream<bool> _mapToIsLoadingState();

  @override
  ManageTodoBlocEvents get events => this;

  @override
  ManageTodoBlocStates get states => this;

  @override
  void dispose() {
    _$setTitleEvent.close();
    _$setDescriptionEvent.close();
    _$saveTodoEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
