import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../app_extensions.dart';
import '../../base/enums/new_todo_enum.dart';
import '../bloc/manage_todo_bloc.dart';

class AddTodoToastMessage extends StatelessWidget {
  const AddTodoToastMessage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      RxBlocListener<ManageTodoBlocType, NewTodoEnum>(
        state: (bloc) => bloc.states.newTodo,
        listener: (context, state) {
          switch (state) {
            case NewTodoEnum.newTodoSuccess:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.featureAddTodo.todoCreatedSuccess),
                ),
              );
              break;
            case NewTodoEnum.newTodoError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.featureAddTodo.todoCreatedError,
                  ),
                ),
              );
              break;
            case NewTodoEnum.editTodoSuccess:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.featureAddTodo.todoEditSuccess,
                  ),
                ),
              );
              break;
          }
        },
        child: child,
      );
}
