import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/todo_details_bloc.dart';

class TodoDetialsDependecies {
  TodoDetialsDependecies._(this.context);

  factory TodoDetialsDependecies.from(BuildContext context) =>
      TodoDetialsDependecies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoDetailsBlocType>(
      create: (context) => TodoDetailsBloc(
        navigationBloc: context.read(),
        coordinatorBloc: context.read(),
        todoService: context.read(),
      ),
    )
  ];
}
