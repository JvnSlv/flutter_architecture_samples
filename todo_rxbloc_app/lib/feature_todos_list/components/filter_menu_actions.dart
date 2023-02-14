import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../app_extensions.dart';
import '../../base/enums/filter_enum.dart';
import '../bloc/todos_list_bloc.dart';

class FilterMenuActions extends StatelessWidget {
  const FilterMenuActions({super.key});

  @override
  Widget build(BuildContext context) =>
      RxBlocBuilder<TodosListBlocType, FilterEnum>(
        state: (bloc) => bloc.states.filterValue,
        builder: (context, snapshot, bloc) => PopupMenuButton(
          icon: Icon(
            context.designSystem.icons.filter,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () => bloc.events.filterMenuAction(FilterEnum.showAll),
              child: Text(
                context.l10n.featureTodosList.showAll,
                style: snapshot.data == FilterEnum.showAll
                    ? TextStyle(color: context.designSystem.colors.cyan)
                    : null,
              ),
            ),
            PopupMenuItem(
              onTap: () => bloc.events.filterMenuAction(FilterEnum.showActive),
              child: Text(
                context.l10n.featureTodosList.showActive,
                style: snapshot.data == FilterEnum.showActive
                    ? TextStyle(color: context.designSystem.colors.cyan)
                    : null,
              ),
            ),
            PopupMenuItem(
              onTap: () =>
                  bloc.events.filterMenuAction(FilterEnum.showCompleted),
              child: Text(
                context.l10n.featureTodosList.showCompleted,
                style: snapshot.data == FilterEnum.showCompleted
                    ? TextStyle(color: context.designSystem.colors.cyan)
                    : null,
              ),
            ),
          ],
        ),
      );
}
