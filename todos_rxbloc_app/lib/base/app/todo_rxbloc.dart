// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../di/app_dependencies.dart';
import '../routers/router.dart';
import '../theme/todo_rxbloc_theme.dart';
import 'config/environment_config.dart';

/// This widget is the root of your application.
class TodoRxbloc extends StatelessWidget {
  TodoRxbloc({
    this.config = const EnvironmentConfig.production(),
    Key? key,
  }) : super(key: key);

  final EnvironmentConfig config;
  final _router = goRouter;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: AppDependencies.of(context, config).providers,
        child: _MyMaterialApp(_router),
      );
}

class _MyMaterialApp extends StatefulWidget {
  const _MyMaterialApp(this._router);

  final GoRouter _router;

  @override
  __MyMaterialAppState createState() => __MyMaterialAppState();
}

class __MyMaterialAppState extends State<_MyMaterialApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo Rxbloc',
      theme: TodoRxblocTheme.buildTheme(DesignSystem.light()),
      darkTheme: TodoRxblocTheme.buildTheme(DesignSystem.dark()),
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: I18n.supportedLocales,
      routerConfig: widget._router,
      debugShowCheckedModeBanner: false,
    );
  }
}
