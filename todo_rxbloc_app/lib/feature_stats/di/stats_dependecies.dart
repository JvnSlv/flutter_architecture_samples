import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/stats_bloc.dart';

class StatsDependecies {
  StatsDependecies._(this.context);

  factory StatsDependecies.from(BuildContext context) =>
      StatsDependecies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<StatsBlocType>(
      create: (context) => StatsBloc(
        todoService: context.read(),
      ),
    ),
  ];
}
