import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../bloc/todos_list_manage_bloc.dart';

class DeleteSuccessToast extends StatelessWidget {
  const DeleteSuccessToast({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RxBlocListener<TodosListManageBlocType, TodoEntity>(
      state: (bloc) => bloc.states.todoDeleted,
      listener: (context, todo) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: DeleteToast(
              todo: todo,
              onTap: () {
                context.read<TodosListManageBlocType>().events.addTodo(todo);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class DeleteToast extends StatelessWidget {
  const DeleteToast({
    Key? key,
    required this.todo,
    required this.onTap,
  }) : super(key: key);
  final TodoEntity todo;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${todo.task}  ${context.l10n.featureTodosList.successDelete}'),
        GestureDetector(
          onTap: onTap,
          child: Text(context.l10n.featureTodosList.undo),
        )
      ],
    );
  }
}
