import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../bloc/manage_todo_bloc.dart';

class ManageTodoDependecies {
  ManageTodoDependecies._(this.context, this.todo);

  factory ManageTodoDependecies.from(BuildContext context, TodoEntity? todo) =>
      ManageTodoDependecies._(context, todo);

  final BuildContext context;
  final TodoEntity? todo;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  List<SingleChildWidget> get _blocs => [
        RxBlocProvider<ManageTodoBlocType>(
          create: (context) => ManageTodoBloc(
            manageTodoService: context.read(),
            navigationBloc: context.read(),
            coordinatorBloc: context.read(),
            todo: todo,
          ),
        )
      ];
}
