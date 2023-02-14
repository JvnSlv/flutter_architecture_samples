import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../app_extensions.dart';
import '../../feature_homepage/components/popup_menu_actions.dart';
import '../blocs/stats_bloc.dart';
import '../models/todo_stats.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.featureStats.statsAppBarTitle),
          actions: const [PopupMenuActions()],
        ),
        body: RxResultBuilder<StatsBlocType, TodoStats>(
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
                    snapshot.completedTodos.toString(),
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
                    snapshot.activeTodos.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
