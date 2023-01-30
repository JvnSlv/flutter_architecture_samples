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
      routes: [
        GoRouteData.$route(
          path: 'addTodo',
          factory: $AddTodoRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'todoDetails/:id',
          factory: $TodoDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $TodoListRouteExtension on TodoListRoute {
  static TodoListRoute _fromState(GoRouterState state) => const TodoListRoute();

  String get location => GoRouteData.$location(
        '/list',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $AddTodoRouteExtension on AddTodoRoute {
  static AddTodoRoute _fromState(GoRouterState state) => const AddTodoRoute();

  String get location => GoRouteData.$location(
        '/list/addTodo',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $TodoDetailsRouteExtension on TodoDetailsRoute {
  static TodoDetailsRoute _fromState(GoRouterState state) => TodoDetailsRoute(
        state.params['id']!,
        $extra: state.extra as TodoEntity?,
      );

  String get location => GoRouteData.$location(
        '/list/todoDetails/${Uri.encodeComponent(id)}',
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
