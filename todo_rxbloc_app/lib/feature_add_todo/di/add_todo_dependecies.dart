import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uuid/uuid.dart';

import '../bloc/add_todo_bloc.dart';

class AddTodoDependecies {
  AddTodoDependecies._(this.context);

  factory AddTodoDependecies.from(BuildContext context) =>
      AddTodoDependecies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  List<SingleChildWidget> get _blocs => [
        RxBlocProvider<AddTodoBlocType>(
          create: (context) => AddTodoBloc(
            todoService: context.read(),
            uuid: const Uuid(),
            navigationBloc: context.read(),
          ),
        )
      ];
}
