import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../blocs/stats_bloc.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.featureStats.statsAppBarTitle),
      ),
      body: RxResultBuilder<StatsBlocType, List<TodoEntity>>(
        state: (bloc) => bloc.states.getTodoList,
        buildLoading: (context, bloc) => const Center(
          child: CircularProgressIndicator(),
        ),
        buildError: (context, exception, bloc) => Center(
          child: Text(context.l10n.featureStats.error),
        ),
        buildSuccess: (context, snapshot, bloc) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  context.l10n.featureStats.completedTodos,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  snapshot
                      .where((element) => element.complete == true)
                      .length
                      .toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  context.l10n.featureStats.activeTodos,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  snapshot
                      .where((element) => element.complete != true)
                      .length
                      .toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
