// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'home_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class HomeBlocType extends RxBlocTypeBase {
  HomeBlocEvents get events;
  HomeBlocStates get states;
}

/// [$HomeBloc] extended by the [HomeBloc]
/// {@nodoc}
abstract class $HomeBloc extends RxBlocBase
    implements HomeBlocEvents, HomeBlocStates, HomeBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [setPageIndex]
  final _$setPageIndexEvent = BehaviorSubject<int>.seeded(0);

  /// The state of [getPageIndex] implemented in [_mapToGetPageIndexState]
  late final Stream<int> _getPageIndexState = _mapToGetPageIndexState();

  @override
  void setPageIndex(int pageIndex) => _$setPageIndexEvent.add(pageIndex);

  @override
  Stream<int> get getPageIndex => _getPageIndexState;

  Stream<int> _mapToGetPageIndexState();

  @override
  HomeBlocEvents get events => this;

  @override
  HomeBlocStates get states => this;

  @override
  void dispose() {
    _$setPageIndexEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
