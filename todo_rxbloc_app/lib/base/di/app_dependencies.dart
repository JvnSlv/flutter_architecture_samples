// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_repository_local_storage/todos_repository_local_storage.dart';

import '../../feature_homepage/bloc/navigation_bloc.dart';
import '../app/config/environment_config.dart';
import '../common_blocs/coordinator_bloc.dart';
import '../routers/router.dart';
import '../services/todo_service.dart';
import '../utils/constants.dart';
import '../utils/todos_data.dart';

class AppDependencies {
  AppDependencies._(this.context, this.config);

  factory AppDependencies.of(
          BuildContext context, EnvironmentConfig envConfig) =>
      _instance != null
          ? _instance!
          : _instance = AppDependencies._(context, envConfig);

  static AppDependencies? _instance;

  final BuildContext context;
  final EnvironmentConfig config;

  /// List of all providers used throughout the app
  List<SingleChildWidget> get providers => [
        ..._coordinator,
        ..._analytics,
        ..._environment,
        ..._mappers,
        ..._httpClients,
        ..._dataStorages,
        ..._dataSources,
        ..._repositories,
        ..._useCases,
        ..._blocs,
        ..._interceptors,
      ];

  List<SingleChildWidget> get _coordinator => [
        RxBlocProvider<CoordinatorBlocType>(
          create: (context) => CoordinatorBloc(),
        ),
      ];

  List<Provider> get _analytics => [];

  List<Provider> get _environment => [
        Provider<EnvironmentConfig>.value(value: config),
      ];

  List<Provider> get _mappers => [];

  List<Provider> get _httpClients => [];

  List<SingleChildWidget> get _dataStorages => [];

  List<Provider> get _dataSources => [
        Provider<TodoService>(
            create: (context) => TodoService(
                  ReactiveLocalStorageRepository(
                    seedValue: listOfTods,
                    repository: KeyValueStorage(
                      TodoConstants.keyValueStorageKey,
                      SharedPreferences.getInstance(),
                    ),
                  ),
                ))
      ];

  List<Provider> get _repositories => [];

  List<Provider> get _useCases => [];

  List<SingleChildWidget> get _blocs => [
        RxBlocProvider<NavigationBlocType>(
          create: (context) => NavigationBloc(router: goRouter),
        ),
      ];

  List<Provider> get _interceptors => [];
}
