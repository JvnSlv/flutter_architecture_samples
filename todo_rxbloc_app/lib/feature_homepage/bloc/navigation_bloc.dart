import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_extensions.dart';
import '../../base/common_blocs/coordinator_bloc.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/model/navigation_parametars.dart';
import '../../base/utils/constants.dart';

part 'navigation_bloc.rxb.g.dart';

abstract class NavigationBlocEvents {
  @RxBlocEvent(
      type: RxBlocEventType.behaviour,
      seed: NavigationParametars(navigationEnum: NavigationEnum.todosList))
  void setPageIndex(NavigationParametars currentPage);
}

abstract class NavigationBlocStates {
  Stream<NavigationParametars> get getPageIndex;
}

@RxBloc()
class NavigationBloc extends $NavigationBloc {
  NavigationBloc({required this.coordinatorBloc, required this.router});
  final GoRouter router;
  final CoordinatorBlocType coordinatorBloc;

  @override
  Stream<NavigationParametars> _mapToGetPageIndexState() => Rx.merge([
        _$setPageIndexEvent.doOnData((event) {
          if (event.navigationEnum == NavigationEnum.todosList) {
            router.go(TodoConstants.listRoute);
          } else {
            router.go(TodoConstants.statsRoute);
          }
        }),
        coordinatorBloc.states.navigation.doOnData((event) {
          switch (event.navigationEnum) {
            case NavigationEnum.todosList:
              router.go(TodoConstants.listRoute);
              break;
            case NavigationEnum.stats:
              router.go(TodoConstants.statsRoute);
              break;
            case NavigationEnum.addTodo:
              router.push(TodoConstants.addTodoRoute);
              break;
            case NavigationEnum.todoDetails:
              router.push(
                TodoConstants.todoDetails,
                extra: event.extraParametars,
              );
              break;
            case NavigationEnum.pop:
              router.pop();
              break;
          }
        })
      ]);
}
