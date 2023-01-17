import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/utils/constants.dart';

part 'navigation_bloc.rxb.g.dart';

abstract class NavigationBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: NavigationEnum.todosList)
  void setPageIndex(NavigationEnum currentPage);
}

abstract class NavigationBlocStates {
  Stream<NavigationEnum> get getPageIndex;
}

@RxBloc()
class NavigationBloc extends $NavigationBloc {
  NavigationBloc({required this.router});
  final GoRouter router;

  @override
  Stream<NavigationEnum> _mapToGetPageIndexState() =>
      _$setPageIndexEvent.doOnData((event) {
        if (event == NavigationEnum.todosList) {
          router.go(TodoConstants.listRoute);
        } else {
          router.go(TodoConstants.statsRoute);
        }
      });
}
