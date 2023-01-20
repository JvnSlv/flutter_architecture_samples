import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../../base/routers/router.dart';

part 'navigation_bloc.rxb.g.dart';

abstract class NavigationBlocEvents {
  void navigate(NavigationParametars navigationParametars);
}

abstract class NavigationBlocStates {
  Stream<NavigationParametars> get getPageIndex;
}

@RxBloc()
class NavigationBloc extends $NavigationBloc {
  NavigationBloc({required this.router});
  final GoRouter router;

  @override
  Stream<NavigationParametars> _mapToGetPageIndexState() =>
      _$navigateEvent.doOnData((event) {
        switch (event.navigationEnum) {
          case NavigationEnum.todosList:
            router.go(const TodoListRoute().location);
            break;
          case NavigationEnum.stats:
            router.go(const StatsRoute().location);
            break;
          case NavigationEnum.addTodo:
            router.push(const AddTodoRoute().location);
            break;
          case NavigationEnum.todoDetails:
            if (event.extraParametars != null) {
              final TodoEntity todo = event.extraParametars as TodoEntity;
              router.push(TodoDetailsRoute(todo.id).location, extra: todo);
            }
            break;
          case NavigationEnum.pop:
            router.pop();
            break;
        }
      });
}
