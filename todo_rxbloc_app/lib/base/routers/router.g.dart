// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $todoListRoute,
      $statsRoute,
    ];

GoRoute get $todoListRoute => GoRouteData.$route(
      path: '/list',
      factory: $TodoListRouteExtension._fromState,
    );

extension $TodoListRouteExtension on TodoListRoute {
  static TodoListRoute _fromState(GoRouterState state) => const TodoListRoute();

  String get location => GoRouteData.$location(
        '/list',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $statsRoute => GoRouteData.$route(
      path: '/stats',
      factory: $StatsRouteExtension._fromState,
    );

extension $StatsRouteExtension on StatsRoute {
  static StatsRoute _fromState(GoRouterState state) => const StatsRoute();

  String get location => GoRouteData.$location(
        '/stats',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
