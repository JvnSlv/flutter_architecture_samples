import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../app_extensions.dart';
import '../../base/enums/new_todo_enum.dart';
import '../bloc/add_todo_bloc.dart';

class AddTodoToastMessage extends StatelessWidget {
  const AddTodoToastMessage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RxBlocListener<AddTodoBlocType, NewTodoEnum>(
      state: (bloc) => bloc.states.newTodo,
      listener: (context, state) {
        if (state == NewTodoEnum.newTodoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.featureAddTodo.todoCreatedSuccess),
            ),
          );
        } else if (state == NewTodoEnum.newTodoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.l10n.featureAddTodo.todoCreatedError,
              ),
            ),
          );
        }
      },
      child: child,
    );
  }
}
