import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../bloc/todos_list_bloc.dart';

class DeleteSuccessToast extends StatelessWidget {
  const DeleteSuccessToast({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RxBlocListener<TodosListBlocType, TodoEntity>(
      state: (bloc) => bloc.states.isTodoDeleted,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${state.task}  ${context.l10n.featureTodosList.successDelete}'),
                GestureDetector(
                  child: Text(context.l10n.featureTodosList.undo),
                  onTap: () {
                    context.read<TodosListBlocType>().events.addTodo(state);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                )
              ],
            ),
          ),
        );
      },
      child: child,
    );
  }
}
