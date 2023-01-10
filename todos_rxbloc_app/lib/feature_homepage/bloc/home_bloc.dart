import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'home_bloc.rxb.g.dart';

/// A contract class containing all events of the HomeBloC.
abstract class HomeBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: 0)
  void setPageIndex(int pageIndex);
}

/// A contract class containing all states of the HomeBloC.
abstract class HomeBlocStates {
  Stream<int> get getPageIndex;
}

@RxBloc()
class HomeBloc extends $HomeBloc {
  @override
  Stream<int> _mapToGetPageIndexState() => _$setPageIndexEvent;
}
