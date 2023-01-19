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

  /// Тhe [Subject] where events sink to by calling [setPageIndex]
  final _$setPageIndexEvent = BehaviorSubject<NavigationParametars>.seeded(
      NavigationParametars(navigationEnum: NavigationEnum.todosList));

  /// The state of [getPageIndex] implemented in [_mapToGetPageIndexState]
  late final Stream<NavigationParametars> _getPageIndexState =
      _mapToGetPageIndexState();

  @override
  void setPageIndex(NavigationParametars currentPage) =>
      _$setPageIndexEvent.add(currentPage);

  @override
  Stream<NavigationParametars> get getPageIndex => _getPageIndexState;

  Stream<NavigationParametars> _mapToGetPageIndexState();

  @override
  NavigationBlocEvents get events => this;

  @override
  NavigationBlocStates get states => this;

  @override
  void dispose() {
    _$setPageIndexEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
