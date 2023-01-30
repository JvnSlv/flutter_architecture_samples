// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'navigation_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class NavigationBlocType extends RxBlocTypeBase {
  NavigationBlocEvents get events;
  NavigationBlocStates get states;
}

/// [$NavigationBloc] extended by the [NavigationBloc]
/// {@nodoc}
abstract class $NavigationBloc extends RxBlocBase
    implements NavigationBlocEvents, NavigationBlocStates, NavigationBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [navigate]
  final _$navigateEvent = PublishSubject<NavigationParams>();

  /// The state of [getPageIndex] implemented in [_mapToGetPageIndexState]
  late final Stream<NavigationParams> _getPageIndexState =
      _mapToGetPageIndexState();

  @override
  void navigate(NavigationParams navigationParametars) =>
      _$navigateEvent.add(navigationParametars);

  @override
  Stream<NavigationParams> get getPageIndex => _getPageIndexState;

  Stream<NavigationParams> _mapToGetPageIndexState();

  @override
  NavigationBlocEvents get events => this;

  @override
  NavigationBlocStates get states => this;

  @override
  void dispose() {
    _$navigateEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
