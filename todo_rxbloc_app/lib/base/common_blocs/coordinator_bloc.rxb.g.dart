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

  /// Тhe [Subject] where events sink to by calling [navigate]
  final _$navigateEvent = PublishSubject<NavigationParametars>();

  /// The state of [navigation] implemented in [_mapToNavigationState]
  late final Stream<NavigationParametars> _navigationState =
      _mapToNavigationState();

  @override
  void navigate(NavigationParametars navigationParametars) =>
      _$navigateEvent.add(navigationParametars);

  @override
  Stream<NavigationParametars> get navigation => _navigationState;

  Stream<NavigationParametars> _mapToNavigationState();

  @override
  CoordinatorEvents get events => this;

  @override
  CoordinatorStates get states => this;

  @override
  void dispose() {
    _$navigateEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
