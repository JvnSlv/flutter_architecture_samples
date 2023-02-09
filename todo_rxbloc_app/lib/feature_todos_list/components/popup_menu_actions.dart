import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../app_extensions.dart';
import '../../base/enums/options_menu_enum.dart';
import '../bloc/todos_list_manage_bloc.dart';

class PopupMenuActions extends StatelessWidget {
  const PopupMenuActions({super.key});

  @override
  Widget build(BuildContext context) =>
      RxBlocBuilder<TodosListManageBlocType, OptionsMenuEnum>(
        state: (bloc) => bloc.states.markTodosComplete,
        builder: (context, snapshot, bloc) => PopupMenuButton(
          icon: Icon(context.designSystem.icons.moreVertical),
          itemBuilder: (context) => [
            (snapshot.hasData &&
                    snapshot.data == OptionsMenuEnum.markAllIncomplete)
                ? PopupMenuItem(
                    onTap: () =>
                        bloc.events.markAll(OptionsMenuEnum.markAllComplete),
                    child: Text(context.l10n.featureTodosList.markAllDone),
                  )
                : PopupMenuItem(
                    onTap: () =>
                        bloc.events.markAll(OptionsMenuEnum.markAllIncomplete),
                    child: Text(context.l10n.featureTodosList.markAllActive),
                  ),
            PopupMenuItem(
              onTap: () => bloc.events.deleteMarkerd(),
              child: Text(context.l10n.featureTodosList.removeDone),
            ),
          ],
        ),
      );
}
