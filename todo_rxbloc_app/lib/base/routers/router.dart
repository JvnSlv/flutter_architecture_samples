// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../feature_homepage/views/home_page.dart';
import '../../feature_manage_todo/di/manage_todo_dependecies.dart';
import '../../feature_manage_todo/views/manage_todo.dart';
import '../../feature_stats/di/stats_dependecies.dart';
import '../../feature_stats/views/stats_page.dart';
import '../../feature_todo_details/di/todo_details_dependecies.dart';
import '../../feature_todo_details/views/todo_details_page.dart';
import '../../feature_todos_list/di/todos_list_dependecies.dart';
import '../../feature_todos_list/views/todos_list_page.dart';
import '../utils/constants.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: TodoConstants.listRoute,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) =>
          HomePage(child: child),
      routes: $appRoutes,
    ),
  ],
);

@TypedGoRoute<TodoListRoute>(
  path: TodoConstants.listRoute,
  routes: [
    TypedGoRoute<ManageTodoRoute>(
      path: TodoConstants.manageTodoRoute,
    ),
    TypedGoRoute<TodoDetailsRoute>(
      path: TodoConstants.todoDetails,
    ),
  ],
)
class TodoListRoute extends GoRouteData {
  const TodoListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: MultiProvider(
          providers: TodosListDependecies.from(context).providers,
          child: const TodosListPage(),
        ),
      );
}

class TodoDetailsRoute extends GoRouteData {
  const TodoDetailsRoute(
    this.id, {
    this.$extra,
  });
  final String id;
  final TodoEntity? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      child: MultiProvider(
        providers: TodoDetialsDependecies.from(context).providers,
        child: TodoDetailsPage(todo: $extra!, id: id),
      ),
    );
  }
}

class ManageTodoRoute extends GoRouteData {
  ManageTodoRoute({this.$extra});
  final TodoEntity? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: MultiProvider(
          providers: ManageTodoDependecies.from(context, $extra).providers,
          child: ManageTodoPage(todo: $extra),
        ),
      );
}

@TypedGoRoute<StatsRoute>(
  path: TodoConstants.statsRoute,
)
class StatsRoute extends GoRouteData {
  const StatsRoute();
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: MultiProvider(
          providers: StatsDependecies.from(context).providers,
          child: const StatsPage(),
        ),
      );
}
