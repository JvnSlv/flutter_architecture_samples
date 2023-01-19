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
import 'package:uuid/uuid.dart';

import '../bloc/add_todo_bloc.dart';

class AddTodoDependecies {
  AddTodoDependecies._(this.context);

  factory AddTodoDependecies.of(BuildContext context) => _instance != null
      ? _instance!
      : _instance = AddTodoDependecies._(context);

  static AddTodoDependecies? _instance;

  final BuildContext context;

  /// List of all providers used throughout the app
  List<SingleChildWidget> get providers => [
        ..._blocs,
      ];

  List<SingleChildWidget> get _blocs => [
        RxBlocProvider<AddTodoBlocType>(
          create: (context) => AddTodoBloc(
            todoService: context.read(),
            uuid: const Uuid(),
            coordinatorBloc: context.read(),
          ),
        )
      ];
}
