// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature_homepage/views/home_page.dart';
import '../../feature_stats/views/stats_page.dart';
import '../../feature_todos_list/views/todos_list_page.dart';
import '../utils/constants.dart';

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
        routes: [
          GoRoute(
            path: TodoConstants.listRoute,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: TodosListPage());
            },
          ),
          GoRoute(
            path: TodoConstants.statsRoute,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: StatsPage());
            },
          ),
        ])
  ],
);
