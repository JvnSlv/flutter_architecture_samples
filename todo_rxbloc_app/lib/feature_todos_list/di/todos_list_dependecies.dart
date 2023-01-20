import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../bloc/todos_list_bloc.dart';

class TodosListDependecies {
  TodosListDependecies._(this.context);

  factory TodosListDependecies.from(BuildContext context) =>
      TodosListDependecies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodosListBlocType>(
      create: (context) => TodosListBloc(
        todoService: context.read(),
        navigationBloc: context.read(),
      ),
    )
  ];
}
