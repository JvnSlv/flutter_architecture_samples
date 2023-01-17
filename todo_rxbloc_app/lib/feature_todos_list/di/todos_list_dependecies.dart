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

import '../../base/routers/router.dart';
import '../bloc/todos_list_bloc.dart';

class TodosListDependecies {
  TodosListDependecies._(this.context);

  factory TodosListDependecies.of(BuildContext context) => _instance != null
      ? _instance!
      : _instance = TodosListDependecies._(context);

  static TodosListDependecies? _instance;

  final BuildContext context;

  /// List of all providers used throughout the app
  List<SingleChildWidget> get providers => [
        ..._blocs,
      ];

  List<SingleChildWidget> get _blocs => [
        RxBlocProvider<TodosListBlocType>(
          create: (context) => TodosListBloc(
            todoService: context.read(),
            router: goRouter,
          ),
        )
      ];
}
